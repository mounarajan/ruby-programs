require 'semantics3'
require 'rubygems'
require 'spreadsheet'  
API_KEY = 'SEM3F9D850FC03D7FD2E5CE68994B98243C9'
API_SECRET = 'OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY'
# Set up a client to talk to the Semantics3 API
sem3 = Semantics3::Products.new(API_KEY,API_SECRET)
url = "Linio_batch1_semantic_24092014.xls" 
book = nil 
a1 = Array.new
a2 = Array.new
a3 = Array.new
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
File.open("test.txt", 'w+') do |file|
a1.each_with_index do |a, i|
sem3.products_field( "brand", a )
sem3.products_field( "model", a2[i] )
productsHash = sem3.get_products 
if productsHash.has_key?("message")
puts "Result Array not found"
file.write "f"
file.puts
else
prod = productsHash["results"][0]
if prod.has_key?("ean")
puts prod["ean"]
a3 << prod["ean"]
file.write prod["ean"]
file.puts
else
file.write ""
file.puts
puts "EAN Not foound"
end
end
end
end
puts a3.length
