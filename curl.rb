require 'curb'
cat_urls = Array.new
c = Curl.get("http://www.amazon.com/s/ref=sr_pg_12?rh=n%3A172282&page=12&ie=UTF8&qid=1411108986")
c.perform
puts data = c.body_str
if data.match(/class="a-link-normal a-text-normal"\s* href="[^\"]*\""/)
puts data.match(/class="a-link-normal a-text-normal"\s* href="[^\"]*\""/)
else
	puts "failed"
end
