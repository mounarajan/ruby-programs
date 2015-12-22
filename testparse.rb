a = Array.new
doc = "<span>Hi welcome to world</span>"
len = doc.length
#while doc
#puts doc.scan(/o/)
#end
a = doc.scan(/o/)
puts a.length
