
require 'rubygems'
require 'nokogiri'
require 'curb'
require 'httparty'
a = Array.new
file = ["amazon_cat.urls"]
File.foreach(file[0]) do |urls|

#http = Curl.get("http://www.google.com/")
#hi = http.body_str
#f.print hi
#puts urls
#url = "http://www.amazon.com/s/ref=sr_pg_12?rh=n%3A172282&page=12&ie=UTF8&qid=1411108986"
hi = HTTParty.get(urls)

#if hi.match(/class="a-link-normal a-text-normal"\s* href="[^\"]*\"/) | hi.scan(/<a href="[^\"]*\"><div class="image/)
File.open("amazon_prod.urls", 'w+') do |f|
	puts hi.scan(/class="a-link-normal a-text-normal"\s* href="([^\"]*)\"/)
	puts hi.scan(/<a href="([^\"]*)\"><div class="image/)
	a = hi.scan(/<a href="([^\"]*)\"><div class="image/)
	a =  hi.scan(/class="a-link-normal a-text-normal"\s* href="([^\"]*)\"/)
	puts "Welcome"
	sleep(10)
#else
#	puts "Failed"
#end

a.flatten
a.each do |s|
	 f.puts s
end
end
end
