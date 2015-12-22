require 'httparty'


url = "http://www.amazon.com/s/ref=sr_pg_12?rh=n%3A172282&page=12&ie=UTF8&qid=1411108986"
hi = HTTParty.get(url)

if hi.match(/class="a-link-normal a-text-normal"\s* href="[^\"]*\"/)
	puts hi.scan(/class="a-link-normal a-text-normal"\s* href="([^\"]*)\"/)
	#f.write hi.scan(/class="a-link-normal a-text-normal"\s* href="([^\"]*)\"/)
else
	puts "Failed"
end