require 'rubygems'
require 'oauth'
require 'uri'
require 'cgi'
require 'json'
require 'rest-client'
require 'httparty'
#require 'oauth/request_proxy/typhoeus_request'

@api_key = "SEM3F9D850FC03D7FD2E5CE68994B98243C9"
@api_secret = "OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY"
#consumer = OAuth::Consumer.new(@api_key, @api_secret)
#@auth = OAuth::AccessToken.new("SEM3F9D850FC03D7FD2E5CE68994B98243C9","OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY")

def make_request(endpoint,method = "GET",params)
            consumer = OAuth::Consumer.new(@api_key, @api_secret)
            auth = OAuth::AccessToken.new(consumer)
#puts consumer
            base_url = 'https://api.semantics3.com/v1/' 

            if method == "GET"


# The verify credentials endpoint returns a 200 status if
# the request is signed correctly.
               address = URI(base_url+endpoint)

# Set up Net::HTTP to use SSL, which is required by Twitter.
               http = Net::HTTP.new address.host, address.port
               http.use_ssl = true
               http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Build the request and authorize it with OAuth.
               request = Net::HTTP::Get.new address.request_uri
               request.oauth! http, consumer,auth

# Issue the request and return the response.
               http.start
               response = http.request request
                puts "The response status was #{response.code}"
                #request_data = CGI.escape(params)
                #encoded_url = base_url + endpoint + '?q=' + request_data
                #response = @auth.get(encoded_url)
                #puts @auth
                JSON.parse response.body
            else     
                address = URI(base_url+endpoint)
                #response = auth.request(:post, address,params)
                #response = `curl -H "api_key: SEM3F9D850FC03D7FD2E5CE68994B98243C9" https://api.semantics3.com/test/v1/webhooks  -d '{"webhook_uri" : "http://mydomain1.com"}'`
                #puts response
                #oauth_params = {:consumer => consumer, :token => auth,:request_uri => uri}
                #hydra = Typhoeus::Hydra.new
                #req = Typhoeus::Request.new(uri,:method => :post)

                #oauth_helper = OAuth::Client::Helper.new(req, oauth_params)
                #req.options[:headers].merge!({"Authorization" => oauth_helper.header}) # Signs the request
                #hydra.queue(req)
                #hydra.run
                #@response = req.response
                request = Net::HTTP::Post.new address.request_uri,params

# Set up HTTP.
                http             = Net::HTTP.new address.host, address.port
                http.use_ssl     = true
                http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Issue the request.

                request.oauth! http, consumer,auth
                http.start
                response = http.request request

# Parse and print the Tweet if the response code was 200
                puts "The response status was #{response.code}\n"
                
                puts "The response status was #{response.body}"
                  JSON.parse response.body
            end

end

 registrationData = {
    "webhook_uri" => "http://148.251.44.168:5000"
}
#http://57e03a31.ngrok.com
#http://6826a371.ngrok.com
puts make_request("webhooks","GET")
puts make_request("webhooks","POST",registrationData)