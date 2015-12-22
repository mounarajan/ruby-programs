a1  #= ["a","b","c","d"]
    a2 #= ["e","f","g","h"]

a1.each_with_index do |a, i|
    #puts "#{a},#{a2[i]}"
    puts a
    puts a2[i]
    
end
