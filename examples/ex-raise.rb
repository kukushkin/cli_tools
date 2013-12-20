#!/usr/bin/env ruby

puts "hello! 1"
STDOUT.flush
sleep 2
puts "hello! 2"
STDOUT.flush
sleep 2
puts "hello! 3"
STDOUT.flush
sleep 2
raise "This is sample exception"