#require 'pry'
class ConnectionMethods

    def self.depth_first_search(city_name, n)
        city_obj = City.all.find {|x| x.name == city_name}
        queue = []
        visited = [city_name]
        cities = [] #we return this at the end
        if n == 1 #if jumps is one, just return initial connections
            cities = city_obj.connections
        else 
            city_obj.connections.each do |city_todo|
                ##build the initial queue.  The jump number will increment 
                ##for succeeding cities as we go deeper into the tree
                queue << {name: city_todo, jumps: 1}
            end
            while queue.length != 0
                cities << queue[0]
                visited << queue[0][:name]   
                connection_obj = City.all.find {|x| x.name == queue[0][:name]}
                connection_obj_connections = connection_obj.connections - visited
                if queue[0][:jumps] + 1 == n 
                    ##if the connection cities connections will satisfy our jump condition, 
                    ##add its connections to cities and move to the next item in the queue
                    connection_obj_connections.each do |city|
                        cities << {name: city, jumps: queue[0][:jumps] + 1}
                    end
                    queue.shift
                else
                    ##else, dig deeper into the tree and increment the jump count
                    connection_obj_connections.each do |city|
                        queue.insert(1, {name: city, jumps: queue[0][:jumps] + 1})
                    end
                    queue.shift
                end
            end
            cities.sort_by! {|x| x[:jumps] }
            cities.map!{ |x| x[:name] }
        end
        cities.uniq
    end

    def self.breadth_first_search(city_name1, city_name2)
        city1_obj = City.all.find {|x| x.name == city_name1}
        queue = []
        route = []
        possible = false #we return this at the end
        if city_name1 != city_name2 #distinguish between an a_to_b request or a loop request
            if city1_obj.connections.include?(city_name2) #catch if only 1 jump connection between a & b
                route = [city_name1, city_name2]
                possible = true
            else #setup search for "a_to_b"
                city2_obj = City.all.find {|x| x.name == city_name2}
                match_connections = city2_obj.connections
                city1_obj.connections.each {|todo| queue << [todo]}
            end
        else #setup search for "loop"
            match_connections = city1_obj.connections
            city1_obj.connections.each {|todo| queue << [todo]}
        end
        while queue.length != 0
            route << queue[0]
            connection_obj = City.all.find {|x| x.name == queue[0].last}
            connection_queue = connection_obj.connections - route[0].unshift(city1_obj.name)
            match = connection_queue & (match_connections - route[0])
            if match != []
                ##if we find a match between the connection's connections and the start city's connections, 
                ##change our return variable to true and clear the queue
                possible = true
                route[0] << match[0]
                queue.clear
            else
                ##else, prep the route to be added to the queue
                connection_queue.each do |todo_city|
                    copy_route = route[0][0..route[0].length]
                    copy_route.push(todo_city)
                    queue << copy_route
                end
                queue.shift
                route.clear
            end
        end
        possible
    end

end