require 'semantics3'
require 'rubygems'
require 'ccsv'
a1 = Array.new
a2 = Array.new
# Your Semantics3 API Credentials
API_KEY = 'SEM3F9D850FC03D7FD2E5CE68994B98243C9'
API_SECRET = 'OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY'
# Set up a client to talk to the Semantics3 API
sem3 = Semantics3::Products.new(API_KEY,API_SECRET)
File.foreach("extract.txt") do |line|
  a1 << line
 
end
File.foreach("extract1.txt") do |line1|
  a2 << line1
end
#a1.each_with_index do |a, i|
    #puts "#{a},#{a2[i]}"
    #puts a
    #puts a2[i]
    
#end
#puts a1.length
#puts a2.length
a1.each_with_index do |a, i|
sem3.products_field( "brand", a )
sem3.products_field( "model", a2[i] )
productsHash = sem3.get_products
if productsHash.has_key?("message")
puts ["message"]
else
prod = productsHash["results"][0]
puts prod["ean"]
end
end


