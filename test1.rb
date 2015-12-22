require 'rubygems'
require 'oauth'
require 'uri'
require 'cgi'
require 'json'
require 'rest-client'

@api_key = "SEM345BFBA4CDF78B1D2DF81A74A99749EBE"
@api_secret = "YmU0ZjNhM2Y3MjE2MzliY2FiMGUzZGI1YzAzODQ4MDc"
#consumer = OAuth::Consumer.new(@api_key, @api_secret)
#@auth = OAuth::AccessToken.new("SEM3F9D850FC03D7FD2E5CE68994B98243C9","OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY")

def make_request(endpoint,method = "POST",params)
    consumer = OAuth::Consumer.new(@api_key, @api_secret)
    auth = OAuth::AccessToken.new(consumer)
    #puts consumer
    base_url = 'https://api.semantics3.com/v1/'

    # The verify credentials endpoint returns a 200 status if
    # the request is signed correctly.
    address = URI(base_url+endpoint)

    # Set up Net::HTTP to use SSL, which is required by Twitter.
    http = Net::HTTP.new address.host, address.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Build the request and authorize it with OAuth.
    request = Net::HTTP::Post.new address.request_uri
    request.oauth! http, consumer,auth

    # Issue the request and return the response.
    http.start
    request.add_field('Content-Type', 'application/json')
    request.body = params.to_json
    response = http.request request
    JSON.parse response.body

    # Parse and print the Tweet if the response code was 200
    puts "The response status was #{response.code}\n"
    puts "The response status was #{response.body}"

end

registrationData = {
    "webhook_uri" => "http://148.251.44.168:5000"
}
#puts make_request("webhooks","GET")
puts make_request("webhooks","POST",registrationData)


params = {
    "type" => "price.change",
    "product" => {
            "sem3_id" => "1QZC8wchX62eCYS2CACmka"
        },
        "constraints" => {
            "gte" => 10,
            "lte" => 100
        }
}

webhook_id = '7JcGN81u'
endpoint = "webhooks/#{webhook_id}/events"

eventObject = make_request(endpoint,"POST",params)
puts eventObject["id"]
puts eventObject["type"]
puts eventObject["product"]
