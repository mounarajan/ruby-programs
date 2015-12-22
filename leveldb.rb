require 'leveldb-native'
a = Array.new
db = LevelDBNative::DB.new("test16.db")
#db.put "one","hi welcome3"
#db.read_property("test16.db")
#db.stats
#puts db.get "one"
file = "doba_media.upcs"
File.foreach(file) do |l|
	a << l
end

a.each_with_index do |a,i|
#	puts a
db.put "one","#{a}"
end 
db.each do |s,i|
	puts db[s]
	puts db[i]
	#puts db[s]
end