require 'cli_tools/include'

count = 0
puts "Press any key when you've had enough"
while (key = kb_getkey).nil?
  count += 1
  putr "#{count} #{esc_green 'bottles'} hanging on the wall... "
  sleep 1
end
puts # advances to a new line
puts "pressed key code is: #{key[0].ord}"