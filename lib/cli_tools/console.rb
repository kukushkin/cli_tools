module CliTools

# Replaces current line in the output with a new one.
#
def putr( str = '' )
  # move cursor to beginning of line
  cr = "\r"

  # ANSI escape code to clear line from cursor to end of line
  # cf. http://en.wikipedia.org/wiki/ANSI_escape_code
  clear = "\e[0K"

  # reset lines
  reset = cr + clear

  print "#{reset}#{str}"
  $stdout.flush
end

# Puts a 'beep' ANSI code.
#
def put_beep
  print "\a"
  $stdout.flush
end

# Clears console screen and puts cursor in 0,0.
#
def put_cls
  cls = `clear`
  putr cls
end

# Returns ANSI escaped string.
#
def esc_string( esc, text )
  esc+text.to_s+"\e[0m"
end

# Returns ANSI escaped string for the red colored text.
#
def esc_red( text )
  esc_string "\e[31m", text
end

# Returns ANSI escaped string for the green colored text.
#
def esc_green( text )
  esc_string "\e[32m", text
end

# Returns ANSI escaped string for the yellow colored text.
#
def esc_yellow( text )
  esc_string "\e[33m", text
end

# Returns ANSI escaped string for the blue colored text.
#
def esc_blue( text )
  esc_string "\e[34m", text
end

# Returns ANSI escaped string for the bold text.
#
def esc_bold( text )
  esc_string "\e[01;37m", text
end


# Returns pressed key or +nil+ if there is no keyboard input.
#
def kb_getkey
  kb_raw_no_echo_mode

  begin
    return $stdin.read_nonblock(1)
  rescue
    return nil
  ensure
    kb_restore_mode
  end
end

# Switches the input mode to raw and disables echo.
#
# *WARNING*:  This method requires the external "stty" program!
#
# Pasted from +HighLine+ gem.
#
def kb_raw_no_echo_mode
  @tty_state = `stty -g`
  system "stty raw -echo cbreak isig"
end

# Restores a previously saved input mode.
#
# *WARNING*:  This method requires the external "stty" program!
#
# Pasted from +HighLine+ gem.
#
def kb_restore_mode
  system "stty #{@tty_state}"
end

end # module CliTools