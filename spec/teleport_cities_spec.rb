require 'spec_helper'

RSpec.describe TeleportCities do
    
    FileParser.new(File.join(".", "spec", "test_imports", "connections.txt")).parse
    
    
    describe "#parse_and_create" do 
      it "creates City objects from the parsed data" do
        expect(City.all.length).to eq(18)
        city1 = City.all.find {|city| city.name == "Seattle" }
        city2 = City.all.find {|city| city.name == "Washington DC"}
        city3 = City.all.find {|city| city.name == "Atlanta"}
        expect(city1.connections[1]).to eq("Honolulu")
        expect(city2.connections.length).to eq(2)
        expect(city3.connections[0]).to eq("Boston")
      end
      it "creates Request objects from the parsed data" do
        expect(Request.all.length).to eq(6)
        expect(Request.all[0].arguments[:city_from]).to eq("Seattle")
        expect(Request.all[2].type).to eq("a_to_b")
        expect(Request.all[4].type).to eq("loop")
        expect(Request.all[5].arguments[:city]).to eq("Santa Fe")
      end
    end  

    describe "#connection_methods" do
      it "finds all cities that can be visited in N jumps" do
        request1 = Request.all[0]
        request2 = Request.all[1]
        response1 = ConnectionMethods.depth_first_search(request1.arguments[:city_from], request1.arguments[:jumps])
        response2 = ConnectionMethods.depth_first_search(request2.arguments[:city_from], request2.arguments[:jumps])
        expect(response1.length).to eq(9)
        expect(response1[4]).to eq("Salem")
        expect(response2.length).to eq(15)
        expect(response2[7]).to eq("New York City")
      end
      it "determines if A can teleport to B" do
        request1 = Request.all[2]
        request2 = Request.all[3]
        response1 = ConnectionMethods.breadth_first_search(request1.arguments[:city1], request1.arguments[:city2])
        response2 = ConnectionMethods.breadth_first_search(request2.arguments[:city1], request2.arguments[:city2])
        expect(response1).to eq(true)
        expect(response2).to eq(true)
      end

      it "determines if a loop can be accomplished" do
        request1 = Request.all[4]
        request2 = Request.all[5]
        response1 = ConnectionMethods.breadth_first_search(request1.arguments[:city], request1.arguments[:city])
        response2 = ConnectionMethods.breadth_first_search(request2.arguments[:city], request2.arguments[:city])
        expect(response1).to eq(true)
        expect(response2).to eq(true)
      end
    end

    describe "#output" do
      it "outputs correctly formatted responses to requests" do
        expect(Request.output).to eq("cities from Seattle in 2 jumps: Hanover, Burlington, Honolulu, Vancouver, Salem, Portland, Fairbanks, New York City, Santa Fe \ncities from Seattle in 4 jumps: Honolulu, Hanover, Vancouver, Burlington, Salem, Fairbanks, Santa Fe, New York City, Portland, Boston, Oakland, Washington DC, Denver, Orlando, Atlanta \ncan I teleport from New York City to Atlanta: yes \ncan I teleport from Washington DC to Orlando: yes \nloop possible from Oakland: yes \nloop possible from Santa Fe: yes \n")        
      end
    end
    
  
end

