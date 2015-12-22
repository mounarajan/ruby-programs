a = ["mon","tue","thry","fri"]
f = File.open("data.txt","w")
a.each do |s|
f << s
end
