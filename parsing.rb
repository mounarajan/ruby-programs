
require 'rubygems'
require 'nokogiri'
require 'curb'
a = Array.new
File.open("amazon_cat.txt", 'w+') do |f|
#http = Curl.get("http://www.google.com/")
#hi = http.body_str
#f.print hi
url= "http://www.amazon.com"
hi = `wget #{url} -qO -`
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
	j = hi.scan(/a href="([^\"]*)" class="nav_a nav_item"/)
	#j.split(/\n/)
	#puts j
	a.concat j
else
	puts "Failed"
end
#end
#end
a.each do |s|
	v = s
	puts "http://amazon.com#{v}"
	f.write "http://amazon.com#{v}\n"
end
puts a.length
end

