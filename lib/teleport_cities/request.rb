#require 'pry'
class Request

    attr_accessor :type, :arguments

    @@all = []
    @@output = ""

    def initialize(args)
        args.each {|key, value| self.send("#{key}=", value)}
        @@all << self
        self.format

    end


    def format# sends request to a connection method and then output the response
        ###available request.types: "jumps", "a_to_b", and "loop"

        case self.type
        when "jumps"
            response = ConnectionMethods.depth_first_search(self.arguments[:city_from], self.arguments[:jumps])
            @@output.concat("cities from #{self.arguments[:city_from]} in #{self.arguments[:jumps]} #{self.arguments[:jumps] > 1 ? 'jumps' : 'jump'}: #{response.join(', ')} \n")
        when "a_to_b"
            response = ConnectionMethods.breadth_first_search(self.arguments[:city1], self.arguments[:city2])
            canned = "can I teleport from #{self.arguments[:city1]} to #{self.arguments[:city2]}:"
            response ? @@output.concat("#{canned} yes \n") : @@output.concat("#{canned} no \n")
        when "loop"
            response = ConnectionMethods.breadth_first_search(self.arguments[:city], self.arguments[:city])
            canned = "loop possible from #{self.arguments[:city]}:"
            response ? @@output.concat("#{canned} yes \n") : @@output.concat("#{canned} no \n")
        else
            @@output.concat("This request could not be processed. Please check the formatting and spelling of your import txt file. \n")
        end
    end

    def self.output
        @@output
    end
    
    def self.all
        @@all
    end

end