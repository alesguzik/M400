#!/usr/bin/env ruby
require 'socket'
s = TCPSocket.new("ctf.phdays.com", 1165)
user = s.gets.chomp.match(/, (\S+) /)[1]
File.open("coord.txt","a"){|x| x.puts("==#{user}==")}
s.write user+"\r\n"
lines = []
while line = s.gets
  puts line.chomp!
  lines.push line
  if line.match /Find/
    File.open("data","w") do |f|
      lines.each do |l|
        f.puts l
      end
    end
    lines = []
    system "./make.sh"
    p result = `ocaml run.ml`
    File.open("coord.txt","a"){|x| x.puts(result)}
    s.write result+"\r\n"
  end
end
