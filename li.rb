require 'rest-client'
require 'faraday'

response = RestClient.get 'http://example.com'
puts response.code
#conn = Faraday.new(:url => 'http://sushi.com')
#response = conn.post '/nigiri', { :name => 'Maguro' }     # GET http://sushi.com/nigiri/sake.json
#puts response.body