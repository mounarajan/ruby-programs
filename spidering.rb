    require 'anemone'  
    require 'open-uri'  
      array = Array.new
    # crawl this page  
file = File.new("sipder.txt","w+")
    Anemone.crawl("http://www.amazon.com/s/ref=lp_9879861011_pg_3?rh=n%3A7141123011%2Cn%3A9879861011&page=3&ie=UTF8&qid=1411052909") do | anemone |  
      # only process pages in the article directory  
      anemone.on_pages_like(/\/dp\//) do | page | 
        #page.gsub(/(.*\/).*/,/$1.*/) 
        c = page.url
        puts c
        file.puts c 
       
        end
        
      end  
    


#spider("http://www.amazon.com/b/ref=clo_wh_shops_dress?_encoding=UTF8&node=1045024&pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-6&pf_rd_r=0EGHE2Q6FP433SJH5S3F&pf_rd_t=101&pf_rd_p=1919382542&pf_rd_i=1040660")

 




