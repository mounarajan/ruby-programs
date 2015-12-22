#a1 = ["11","22","33","44","55"]
#a2 = ["a","b","c","d","e"]
#a3 = [1,2,"",4,5]

#a4 = Array.new
#a1.each_with_index do |i,j|
#if i.respond_to?(:empty?) && i.empty?
#puts "failed"
#else
#puts a1[j],a2[j],a3[j]
#end
#end

require 'semantics3'
require 'rubygems'
#require 'ccsv'
require 'spreadsheet' 
#require 'open-uri' 
# Your Semantics3 API Credentials
API_KEY = 'SEM3F9D850FC03D7FD2E5CE68994B98243C9'
API_SECRET = 'OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY'
# Set up a client to talk to the Semantics3 API
sem3 = Semantics3::Products.new(API_KEY,API_SECRET)
url = "Linio_batch1_semantic_24092014.xls" 
book = nil 
a1 = Array.new
a2 = Array.new
a3 = Array.new
a4 = Array.new
open url do |f|
 book = Spreadsheet.open f 
end
book.worksheets.each do |sheet| 
#puts "Sheet called #{sheet.name} has #{sheet.row_count} rows and #{sheet.column_count} columns"
s = sheet.column(0)
s.each do |m|
a1 << m
end
s = sheet.column(1)
s.each do |n|
a2 << n
end
s = sheet.column(2)
s.each do |o|
a3 << o
end
end
a1.each do |e|
  if e.respond_to?(:nil?) && e.nil? 
    puts "Nothing here."
  else
    puts e
  end
end
