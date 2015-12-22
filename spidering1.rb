require 'anemone'
 
 
 
#urls = []
Anemone.crawl("http://www.flipkart.com/search?q=mi3&as=off&as-show=on&otracker=start") do |anemone|
anemone.on_pages_like(/\/p\//) do |page|
puts page.url
end
end

 
