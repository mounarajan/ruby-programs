require 'semantics3'
API_KEY = 'SEM3F9D850FC03D7FD2E5CE68994B98243C9'
API_SECRET = 'OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY'
sem3 = Semantics3::Products.new(API_KEY,API_SECRET)
sem3.products_field( "cat_id", 4992 )

# Make the query
productsHash = sem3.get_products()

# View the results of the query
puts productsHash.to_json