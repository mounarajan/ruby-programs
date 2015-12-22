
require 'rubygems'
require 'nokogiri'
require 'curb'
require 'httparty'
a = Array.new
File.open("amazon_cat.txt", 'w+') do |f|
#http = Curl.get("http://www.google.com/")
#hi = http.body_str
#f.print hi
hi = HTTParty.get("http://www.amazon.com")
url= "http://www.amazon.com"
vv = `wget #{url} -qO -`
#hi = a
#f.print hi
#end
#puts hi.class
#puts hi
#if hi.match(/(<html itemscope="" itemtype=")/im)
#	puts hi.match(/<script>([^\)]*\))/im)[1]
#else
#	puts "failed"
#end
#end
#while hi.match(/href="([^\"]*)\"\salt/m)
#puts hi
if hi.match(/<title/i)
	j = hi.scan(/<a href="([^\"]*)\"\sclass="nav\_a\snav\_item/)
	#j.split(/\n/)
	#puts j
	a.concat j
else
	puts "Failed"
end
#end
#end
a.each do |s|
	v = s[0].gsub(/\;/,"\&")
	puts "http://amazon.com#{v}"
	f.puts "http://amazon.com#{v}"
end
puts a.length
end