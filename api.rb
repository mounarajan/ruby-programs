#https://api.semantics3.com/v1/products?q=%22search%22:%20%22iphone%22
require 'rubygems'
require 'oauth'
require 'uri'
require 'cgi'
require 'json'

class Base
def in(api_key,api_secret)
@api_key = api_key
@api_secret = api_secret
raise Error.new('API Credentials Missing','You did not supply an api_key. Please sign up at https://semantics3.com/ to obtain your api_key.','api_key') if api_key == ''
raise Error.new('API Credentials Missing','You did not supply an api_secret. Please sign up at https://semantics3.com/ to obtain your api_secret.','api_secret') if api_secret == ''
consumer = OAuth::Consumer.new(@api_key, @api_secret)
@auth = OAuth::AccessToken.new(consumer)
end
def make_request(endpoint,*params)
	params = params[0]

url = 'https://api.semantics3.com/v1/' + endpoint + '?q=' + params
puts "url = #{url}"
response = @auth.get(url)
#-- Response.code - TBD
JSON.parse response.body
end
end

res = Base.new()
puts res.in("SEM3F9D850FC03D7FD2E5CE68994B98243C9","OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY")
puts res.make_request("products","%7B%0A%20%20%22search%22%3A%20%22iphone%22%0A%7D")