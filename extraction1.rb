require 'spreadsheet' 
require 'open-uri' 
url = "Linio_batch1_semantic_24092014.xls" 
book = nil 
a1 = Array.new
a2 = Array.new
open url do |f|
 book = Spreadsheet.open f 
end
book.worksheets.each do |sheet| 
#puts "Sheet called #{sheet.name} has #{sheet.row_count} rows and #{sheet.column_count} columns"
s = sheet.column(5)
s.each do |m|
a1 << m
end
s = sheet.column(6)
s.each do |n|
a2 << n
end
 end
puts a2




#Examples for csv extraction
#require 'rubygems'
#require 'ccsv'
#a1 = Array.new
#a2 = Array.new
#Ccsv.foreach("extract.csv") do |line|
  #a1 << line[0]
  #a2 << line[1]
  # Do something with the line array
#end

#puts a1
#puts a2

