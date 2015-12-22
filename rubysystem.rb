url = "http://www.buckle.com/siteindex.jsp"
a = `wget -qO- #{url}`
puts a.scan(/<li><a href\=\'([^\']*)\'/i)
puts a.scan(/<li style\=\"font\-size[^>]*><a href='([^\']*)\'/i)