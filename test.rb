require 'semantics3'

# Your Semantics3 API Credentials
API_KEY = 'SEM3F9D850FC03D7FD2E5CE68994B98243C9'
API_SECRET = 'OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY'

# Set up a client to talk to the Semantics3 API
sem3 = Semantics3::Products.new(API_KEY,API_SECRET)

sem3.products_field( "upc", "883974958450" )
sem3.products_field( "fields”, ["name","gtins"] )

# Run the request
productsHash = sem3.get_products()

# View the results of the request
puts productsHash.to_json
