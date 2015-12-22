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
Ccsv.foreach("extract.csv") do |line|
  brand = line[0]
  model = line[1]
  # Do something with the line array
sem3.products_field( "brand", brand )
sem3.products_field( "model", model )
productsHash = sem3.get_products
if productsHash.has_key?("message")
puts "Not reuslts array found"
else
if productsHash["results"].empty?
puts "failed"
else
prod = productsHash["results"][0]
if prod.has_key?("ean")
puts prod["ean"].to_json
else
puts "EAN Not foound"
end
end
end
sleep(1)
end

#puts prod.to_json
