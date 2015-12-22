require 'semantics3'
require 'rubygems'
require 'spreadsheet'  
API_KEY = 'SEM3F9D850FC03D7FD2E5CE68994B98243C9'
API_SECRET = 'OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY'
# Set up a client to talk to the Semantics3 API
sem3 = Semantics3::Products.new(API_KEY,API_SECRET)
url = "Linio_batch1_semantic_24092014.xls" 
book = nil 
a1 = Array.new
a2 = Array.new
a3 = Array.new
a4 = Array.new
open url do |f|
 book = Spreadsheet.open f 
end
book.worksheets.each do |sheet| 
#puts "Sheet called #{sheet.name} has #{sheet.row_count} rows and #{sheet.column_count} columns"
s = sheet.column(0)
s.each do |m|
a1 << m
end
s = sheet.column(1)
s.each do |n|
a2 << n
end
end
File.open("mpn.txt", 'w+') do |file|
  a1.each_with_index do |a, i|
  #Checking whether if EAN column has a nil value or digit in "EAN array"
  if a.respond_to?(:nil?) && a.nil?
    #If it has nil value then the brand and model will be sent to semantics3 API
    sem3.products_field( "mpn", a2[i] )
    #sem3.products_field( "brand", a3[i] )
    #sem3.products_field( "model", a4[i] )
    productsHash = sem3.get_products
    #If the product hash has a key message then will print result array is not found" 
    if productsHash.has_key?("message")
      puts "Result Array not found"
      file.write "f"
      file.puts
    else
      #If it has result array the it will search for key EAN
      prod = productsHash["results"][0]
      if prod.has_key?("ean")
        puts "**** printitng from API - #{prod["ean"]}"
        file.write prod["ean"]
        file.puts
      else
        #If it has no ean then it wil print ean not found
        file.write ""
        file.puts
        puts "EAN Not foound"
      end
    end
  else
    #If EAN array has an entry in "EAN column" Then it wont got to API it will directly print the EAN from file
    puts "** printing from file - #{a}"
    file.write a
    file.puts
  end
 end
end
