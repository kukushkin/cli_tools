require 'cli_tools/include'

if ARGV.size == 0
  puts "Usage: #{__FILE__} <command> [arg1] [arg2] ..."
  puts "Examples:"
  puts "  #{__FILE__} ruby test-err.rb"
  puts "  #{__FILE__} ruby test-putr.rb"
  exit -1
end

out = ''
captured = ''
begin
  sh ARGV.join(' '), true, captured do |char|
    putc char
  end
  puts esc_green "OK"
  puts "captured output (captured):"
  puts captured
  puts
rescue ShellExecutionError => e
  puts esc_red "ERROR: #{e}, status:#{e.status}, output:"
  puts e.output
  puts
end
