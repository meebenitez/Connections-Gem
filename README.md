

# Connections-Gem

Calculate the following teleportation connection requests:

1. What cities can you reach from city X with a maximum of N jumps? 
2. Can you get from city X to city y?
3. Starting in city X, is it possible to travel in a loop (leave the city on one route and return on another without traveling along the same route twice)?

## Design

This gem has an object-oriented design, creating City objects and Request (ex: "Can I get from Seattle to Atlanta") objects from an imported .txt file.  A City object is linked to other City objects via their "connections" attribute.

Calculating a "What can you reach from city X with a maximum of N jumps" request uses a depth-first search algorithm, while the other 2 requests ("Is a loop possible from city X?" and "Can city x travel to city y?") utilize a breadth-first search algorithm.

Rspec tests were created for this app.  Please see the "Development" section of the Readme for instructions on running the tests.

## Usage



To use the TeleportCities Ruby Gem please make sure you have Ruby v 2.0.0 or greater installed.

Add your teleportation import file (.txt) to the "./imports/" directory. 
(Note: The ByteCubed test conditions have already been added as sample_input.txt)

From the root directory, run the application:

```
$ ./bin/teleport_cities
```

## Development

Run bundle install:

    $ bundle install

Run tests from the root directory:

    $ bundle exec rspec


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

