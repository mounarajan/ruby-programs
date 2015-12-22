require 'rubygems'
require 'curb'
require 'httparty'
require 'json'

#Extracting category,pagination and product urls from seed file or just use robots file to extract urls 
begin
class Pagextraction
	
    #Downloading webpage content using CURL
	def curl(url)
		if(url.match(/http\:[\w\-\_]+/))
          data  = Curl.get(url)
          @curl_data = data.body_str
        else
        	puts "invalid url"
        end
	end
    #Downloading webpage content using WGET
	def wget(url)
		if(url.match(/http\:\/\/[\w\-\_\.]+/))
	      @wget_data = `wget -qO- #{url}`
	    else
        	puts "invalid url"
        end
	end
    #Downloading webpage content using HttParty Ruby library
	def httparty(url)
		if(url.match(/http\:\/\/[\w\-\_\.]+/))
	      @httparty_data = HTTParty.get(url)
	    else
        	puts "invalid url"
        end
	end
    
    def page_content
    	@curl_data
    	@wget_data
    	@httparty_data
    end

      #Extracting Main Categroy pages
    def category_pages
    	a = page_content.match(/<li><a href\=\'([^\']*)\'/i)
    	b = page_content.match(/<li style\=\"font\-size[^>]*><a href='([^\']*)\'/i)
      if (a or b)
        File.open("buckle_cat.txt", 'w+') do |f|
          puts page_content.scan(/<li><a href\=\'([^\']*)\'/i)
          f.puts page_content.scan(/<li><a href\=\'([^\']*)\'/i)
          f.puts page_content.scan(/<li style\=\"font\-size[^>]*><a href='([^\']*)\'/i)
          puts page_content.scan(/<li style\=\"font\-size[^>]*><a href='([^\']*)\'/i)
        end
      else
      	puts "The give Regex was wrong..Please test it and give the correct one"
      end

    end
      #Extracting Pagination Pages
    def pagination_pages(sle)
      File.open("buckle_cat.txt", 'r') do |pag|
      	pag_count = 0
      	File.open("buckle_pag.txt", 'w+') do |s|
      	pag.each do |p|
      	  pag_count = pag_count + 1
          if pag_count == 5
      	    sleep(sle)
      	    pag_count = 0
      	  end 
      	  url = "http://buckle.com#{p}"
      	  pag_content = httparty(url)
      	  #puts pag_content
      	  if pag_content.match(/<a rel\=\"nofollow\"\shref\=\"([^\"]*page\:\d+)\">\d+<\/a>/)
      	  	  puts pag_content.scan(/<a rel\=\"nofollow\"\shref\=\"([^\"]*page\:\d+)\">\d+<\/a>/)
      	  	  s.puts pag_content.scan(/<a rel\=\"nofollow\"\shref\=\"([^\"]*page\:\d+)\">\d+<\/a>/)
      	  else
      	  	puts "The pagination regex which u gave was wrong please test it and change it"
      	  end
        end
    end
      end
    end
      #Extracting Product pages from pagination pages
    def product_pages(sle)
    	File.open("buckle_pag.txt", 'r') do |pag_cat|
    		cat_pag_count = 0
    		File.open("buckle_prod.txt", 'w+') do |u|
      	    pag_cat.each do |p_c|
      	    cat_pag_count = cat_pag_count + 1
                if cat_pag_count == 5
      	          sleep(sle)
      	          cat_pag_count = 0
      	        end
      	        url = "http://buckle.com#{p_c}"
      	        pag_cat_content = httparty(url)
      	        if pag_cat_content.match(/<a href\=\"([^\"]*sku\-[^\"]*)\"\sclass\=\"prodDetail/i)
                    puts pag_cat_content.scan(/<a href\=\"([^\"]*sku\-[^\"]*)\"\sclass\=\"prodDetail/i)
                    u.puts pag_cat_content.scan(/<a href\=\"([^\"]*sku\-[^\"]*)\"\sclass\=\"prodDetail/i)
                    #f.puts pag_cat_content.scan(/<li style\=\"font\-size[^>]*><a href='([^\']*)\'/i)
                    #puts pag_cat_content.scan(/<li style\=\"font\-size[^>]*><a href='([^\']*)\'/i)
                else
      	          puts "The give Product Regex was wrong..Please test it and give the correct one"
                end
            end
        end
    end
    end
      #Extracting Product pages from category pages
    def product_pages1(sle)
    	File.open("buckle_cat.txt", 'r') do |prod_cat|
    		prod_pag_count = 0
    		File.open("buckle_prod.txt", 'a+') do |v|
      	    prod_cat.each do |pp_c|
      	    prod_pag_count = prod_pag_count + 1
                if prod_pag_count == 5
      	          sleep(sle)
      	          prod_pag_count = 0
      	        end
      	        url = "http://buckle.com#{pp_c}"
      	        pag_cat_content = httparty(url)
      	        if pag_cat_content.match(/<a href\=\"([^\"]*sku\-[^\"]*)\"\sclass\=\"prodDetail/i)
                    puts pag_cat_content.scan(/<a href\=\"([^\"]*sku\-[^\"]*)\"\sclass\=\"prodDetail/i)
                    v.puts pag_cat_content.scan(/<a href\=\"([^\"]*sku\-[^\"]*)\"\sclass\=\"prodDetail/i)
                    v.puts
                    #f.puts pag_cat_content.scan(/<li style\=\"font\-size[^>]*><a href='([^\']*)\'/i)
                    #puts pag_cat_content.scan(/<li style\=\"font\-size[^>]*><a href='([^\']*)\'/i)
                else
      	          puts "The give Product Regex was wrong..Please test it and give the correct one"
                end
            end
        end
    end
    end
      #If the site has robots url lets skip the above step and proceed directly to this step
    def robots
    end

   rescue
  sleep 2
  retry
 end
end

#Extracting Product information from product pages
class ContentExtraction < Pagextraction 

  def extraction(sle)
  products = Hash.new
  results_level_hash = Hash.new
  results_level_array = Array.new
  results_level_array = results_level_hash
  offers_level_hash = Hash.new
  results_level_array = offers_level_hash
  results_level_array = Array.new
  results_level_array = results_level_hash
  features_blob_level_hash = Hash.new
  results_level_array = features_blob_level_hash
  products["results"] = results_level_hash
  products["results"]["offers"] = offers_level_hash
  products["results"]["features"] = features_blob_level_hash
  File.open("buckle_prod.txt", 'r') do |prod_cat|
        prod_pag_count = 0
        File.open("buckle_products.json", 'a+') do |putss|
            prod_cat.each do |pp_c|
            prod_pag_count = prod_pag_count + 1
                if prod_pag_count == 5
                  sleep(sle)
                  prod_pag_count = 0
                end
                url = "http://buckle.com#{pp_c}"
                ext_con = httparty(url)
                url_filter = 
                content_filter = ext_con.match(/h1 id=\"productName\"[^>]*>[^<]*<\/h1>/)
                negative_url_filter = ""
                negative_content_filter = ""
                if (url_filter or content_filter)
                  #puts ext_con.scan(/<title>(.*?)<\/title>/)
                  #Name
                  results_level_hash["name"] = ext_con.scan(/h1 id=\"productName\"[^>]*>([^<]*)<\/h1>/)
                  #Crumb
                  results_level_hash["crumb"] = ext_con.scan(/<strong>View\s*All\:\s*<\/strong><br\s*\/>\s*<a[^>]*>([^<]+)<\/a>/)
                  #Brand
                  results_level_hash["brand"] = ext_con.scan(/brand\:[^\"]*\"\stitle="([^\"]*)\"/)
                  #Description
                  results_level_hash["description"] = ext_con.scan(/pdescription[^>]*>(.*?)<\/div/)
                  #images
                  results_level_hash["images"] = ext_con.scan(/og\:image\"\s*content="([^\"]*)\"/)
                  #siterating
                  results_level_hash["siterating"] = ext_con.scan(/average">([^<]*)</)
                  #siterating_scale
                  results_level_hash["siterating_scale"] = "5"
                  #Reviews_number
                  results_level_hash["siterating"] = ext_con.scan(/count">([^<]*)</)
                  #List price
                  results_level_hash["list_price"] = ext_con.scan(/was[^<]*<span[^\$]*\$[^>]*>(.*?)<\/span/)
                  #List price currency
                  results_level_hash["list_price_currency"] = "USD"
                  #Features_blob should be an array
                  features_blob = ext_con.scan(/tab\-pane">(.*?)<\/ul><\/div/)[0][0]
                  fi = features_blob.scan(/<li>([^<]*)</)
                  features_blob_level_hash["features_blob"] = fi
                  #Price
                  offers_level_hash["price"] = ext_con.scan(/price\:amount\"\scontent="([^\"]*)\"/)
                  #Currency
                  offers_level_hash["currency"] = "USD"
                  #Seller
                  offers_level_hash["seller"] = "Buckle"
                  puts products["results"]
                  putss.puts products["results"]
                else
                  puts "This is not a product page...please use the proper product url"
                end
              end
            end
          end
    end
end
rescue
  sleep 2
  
page_con = ContentExtraction.new
page_con.httparty("http://www.buckle.com/siteindex.jsp")
#puts page_con.page_content.scan(/<TITLE>(.*?)<\/title/i) 
page_con.category_pages
page_con.pagination_pages(60)
page_con.product_pages(60)
page_con.product_pages1(60)
page_con.robots(60)
page_con.extraction(60)
retry
 end