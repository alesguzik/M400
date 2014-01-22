#!/usr/bin/env ruby
dots = []
xy,xz,yz = Array.new(3){ Array.new(50){ Array.new(50){ nil }} }

while gets
  dots.push $_.split(" ").map(&:to_i)
end

dots.each do |(x,y,z)|
  xy[x][y] = true
  xz[x][z] = true
  yz[y][z] = true
end

print "xy"+" "*48
print "xz"+" "*48
print "yz"+" "*48

(0..49).each do |i|
  [xy,xz,yz].each do |set|
    set[i].each do |dot|
      if dot
        print "*"
      else
        print " "
      end
    end
    print "|"
  end
  puts
end
puts "___________________________________________________________________"
