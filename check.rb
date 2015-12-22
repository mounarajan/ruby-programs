a = Array.new
File.foreach("check1.txt") do |line|
  a << line
 
end
puts a.length
puts
