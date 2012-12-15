#!/usr/bin/env ruby
require 'socket'
s = TCPSocket.new("ctf.phdays.com", 1165)
user = s.gets.chomp.match(/, (\S+) /)[1]
s.puts user
lines = []
while line = s.gets
  puts line
  lines.push line
  if line.match /Find/
    File.open("data","w") do |f|
      lines.each do |l|
        f.puts l
      end
    end
    lines = []
    system "./make.sh"
    puts result = `ocaml run.ml`
    s.puts result
  end
end
