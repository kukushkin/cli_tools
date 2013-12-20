require 'open3'

module CliTools

# Execs cmd in a shell and returns true if command executed successfully,
# or throws an exception if command failed.
#
SH_STORED_OUTPUT_LIMIT = 2048
SH_STORED_OUTPUT_LINES = 8
def sh( cmd, echo = true, capture_output = nil, &block )
  if _sh_captured_output.size == 0 && capture_output.nil? && block.nil?
    # simple form
    puts cmd if echo
    system cmd or raise ShellExecutionError.new("Failed to execute: '#{cmd}' (#{$?})", $?, '')
    return true
  end

  # ok, it's a bit more complex
  exit_status = nil
  current_output = ''
  if echo
    _sh_captured_output.each do |output_channel|
      _sh_capture_concat output_channel, cmd+"\n"
    end
    if capture_output
      _sh_capture_concat capture_output, cmd+"\n"
    else
      puts cmd
    end
  end
  i = STDIN
  Open3.popen2e( cmd ) do |i, oe, t|
    i = STDIN
    oe.sync = true
    while oe_char = oe.getc do
      # puts "sh: block tick"
      _sh_captured_output.each do |output_channel|
        _sh_capture_concat output_channel, oe_char
      end
      if capture_output
        _sh_capture_concat capture_output, oe_char
      else
        putc oe_char
      end
      current_output += oe_char
      if current_output.size > SH_STORED_OUTPUT_LIMIT
        # squeeze cached output
        current_output = current_output.split("\n").last(SH_STORED_OUTPUT_LINES).join("\n")
      end
      yield(oe_char) if block
    end
    exit_status = t.value
  end
  if exit_status != 0
    raise ShellExecutionError.new("Failed to execute: '#{cmd}' (#{exit_status})", exit_status, current_output)
  end
  true
end


# Captures all outputs of all the #sh executed inside the block into +output+.
#
def sh_capture_output( output, &block )
  _sh_captured_output << output
  yield
ensure
  _sh_captured_output.delete output
end

# Prints message and captures it if capture output is enabled.
#
def sh_capture_echo( message )
  _sh_captured_output.each do |output_channel|
    _sh_capture_concat output_channel, message+"\n"
  end
end

# Concatenates output buffer and text.
# If output buffer object is a String, the content is #replace-d,
# otherwise object must provide #text property-accessor.
#
def _sh_capture_concat( output_buffer, text )
  if output_buffer.is_a? String
    output_buffer.replace( output_buffer + text )
  else
    output_buffer.text += text
  end
end

# Returns list of capture channels.
# This list is local to the current thread.
#
def _sh_captured_output
  Thread.current[:sh_captured_output] ||= []
  Thread.current[:sh_captured_output]
end

# Exception class which holds command execution status and current output
# for exceptions raised from '#sh' method call.
#
class ShellExecutionError < StandardError
  attr_reader :status, :output
  def initialize( msg = "Failed to execute 'sh'", status, output )
    super msg
    @status = status
    @output = output
  end
end

# Copy file if newer.
#
def copy_if_newer( from, to, echo = true )
  # if Mac OS X:
  os = os_name()
  if os == 'macosx'
    sh "cp -nf #{from} #{to}", echo
  else
    # update, force, preserve attrs
    sh "cp -ufp #{from} #{to}", echo
  end
end

# Returns the amount in bytes of free disk space in the specified folder.
#
def fs_disk_free( path )
  result = `df -P -k #{path}`.split("\n")[1]
  device, d_size, d_usage, d_free = result.split(" ")[0..3]

  d_free.to_i*1024 # in bytes
end

# Returns the amount in bytes of used disk space in the specified folder.
#
def fs_disk_used( path )
  # First, dereference path
  if File.symlink? path
    p = File.readlink( path )
  else
    p = path
  end
  result = `du -ks #{p} 2>/dev/null`
  size = 0
  result.split("\n").each do |line|
    if m = /(\d+)\s+.*/.match(line)
      size += m[1].to_i*1024
    end
  end
  size
end

# Returns a host OS name in lowercase.
#
def os_name
  name = `uname` rescue '' # Windows?
  name.chomp!

  case name
  when 'Darwin' then 'macosx'
  when 'Linux' then 'linux'
  else
    "unknown(#{name})"
  end
end

end # module CliTools