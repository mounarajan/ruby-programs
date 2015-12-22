require 'semantics3'
require 'rubygems'
require 'ccsv'
a1 = Array.new
a2 = Array.new

Ccsv.foreach("extract.csv") do |line|
  brand = line[0]
File.open("output.txt", 'w') do |file|
    file.puts (line[1])
    #file.puts
  end
 
  a2 << line[1]
end

