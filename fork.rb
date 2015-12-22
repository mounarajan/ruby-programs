require 'semantics3'
require 'rubygems'
require 'spreadsheet' 
require 'json'
require 'forkmanager'
API_KEY = 'SEM3F9D850FC03D7FD2E5CE68994B98243C9'
API_SECRET = 'OGU4N2M3OTlkN2EyYTAxYmQxNmQ1ZmI2ZDRlZmI4NGY'
sem3 = Semantics3::Products.new(API_KEY,API_SECRET)
    max_procs = 10 # number of parallel processes to run
     pm = Parallel::ForkManager.new(max_procs) # initiate the parallel fork manager with the max number of procs specified
     
     pm.run_on_start do |pid,ident|
       puts "Starting to do something with file #{ident}, pid: #{pid}"
     end
    
    pm.run_on_finish do |pid,exit_code,ident|
      puts "Finished doing something with file #{ident}"
    end
    
    files = ["do1.xls","do2.xls","do3.xls","do4.xls","do5.xls","do6.xls","do7.xls","do8.xls","do9.xls","do10.xls"]
    urls = Array.new
    files.each do |file|
      pid = pm.start(file) and next # start the process
      #files.each do |file|
# Set up a client to talk to the Semantics3 API
url = file 
book = nil 
a1 = Array.new
a2 = Array.new
a3 = Array.new
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
#Iterating through xls file
File.open("#{file}_upc_extract.txt", 'a+') do |file|
  a1.each_with_index do |a, i|
  #Checking whether if EAN column has a nil value or digit in "EAN array"
  begin 
  if a.respond_to?(:nil?) && a.nil?
    #If it has nil value then the brand and model will be sent to semantics3 API
    sem3.products_field( "mpn", a2[i] )
    #sem3.products_field( "model", model )
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
   rescue 
  sleep 2
  retry
 end
 end
end
      #end
      
      # here's where you do the processing
    #{}`/usr/local/bin/super_processor #{file}`
     
    
     pm.finish # end process
  end
  
    puts "Waiting for all processes to finish..."
    pm.wait_all_children # wait for all processes to complete
    puts "All done!"