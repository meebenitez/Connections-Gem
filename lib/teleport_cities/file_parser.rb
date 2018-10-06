class FileParser
    attr_reader :file

    def initialize(filename)
        @file = filename
    end

    def parse
        File.readlines(file).each do |line|
            #parse line-by-line and send the data to their respective object methods
            if line.include? "cities from"### what cities from A can be reached using n jumps?
                jumps = line.match(/\d+/)[0].to_i
                city = line.split("cities from ").join(" ").split(" in")[0].strip!
                Request.new(type: "jumps", arguments: {city_from: city, jumps: jumps})
            elsif line.include? "can I teleport"### can A teleport to B?
                cities = line.split("can I teleport from ").join(" ").split(" to ")
                city1 = cities[0].strip
                city2 = cities[1].strip
                Request.new(type: "a_to_b", arguments: {city1: city1, city2: city2})
            elsif line.include? "loop possible"### is a loop possible A?
                city = line.split("loop possible from")[1].strip!
                Request.new(type: "loop", arguments: {city: city})
            else
                city1 = line.split("-")[0].strip
                city2 = line.split("-")[1].strip
                City.create_connections(city1, city2)
            end
        end
    end
end