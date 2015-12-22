class Variable
    @inside_class = "Hi this is inside the class"
end
class Outside < Varibale
    def pps
        return @inside_class
    end
end

show = Outside.new
puts show.pps()