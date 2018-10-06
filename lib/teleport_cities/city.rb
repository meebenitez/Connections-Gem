class City

    attr_accessor :name, :connections

    @@all = []

    def initialize(args)
        args.each {|key, value| self.send("#{key}=", value)}
        @@all << self
    end

    def self.create_connections(city1, city2)
        create_or_update_city(city1, city2) 
        create_or_update_city(city2, city1)
    end

    def self.create_or_update_city(city_name, connection)
        city_obj = @@all.find {|city| city.name == city_name}
        if city_obj != nil
            add_connection(city_obj, connection)
        else
            city_obj = self.new(name: city_name, connections: [])
            add_connection(city_obj, connection)
        end
    end

    def self.add_connection(city, connection)
        city.connections << connection
    end

    def self.all
        @@all
    end

end