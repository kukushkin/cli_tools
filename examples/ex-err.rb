#!/usr/bin/env ruby
require 'cli_tools/include'

1.upto(10) do |i|
  puts "this is stdout output #{i}"
  STDOUT.flush
  STDERR.puts esc_red "this is stderr output #{i}"
  STDERR.flush
  sleep 1
end
exit -1
