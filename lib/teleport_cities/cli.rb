class TeleportCities::CLI

    def call
        puts "Welcome to the Teleportation Connection Calculator"
        FileParser.new(pick_files).parse #parse file and create City and Request objects
        $stdout.puts Request.output
    end

    def pick_files #displays all the .txt files in the import directory and asks the user to pick one
        files = []
        Dir.glob(File.join(".", "imports", "*.txt")) do |txt_file|
            files << txt_file.gsub(/[^\/]*\//, '')
        end
        puts "Please choose a file to import:"
        files.each_with_index {|choice, index| puts "#{index + 1}. #{choice}"}
        input = number_input_validator(files.length).to_i - 1
        puts "Calculating your results...."
        File.join(".", "imports", files[input])
    end

    def number_input_validator(num_options) #helper method for pick_files, validates user input
        input = gets.strip
        valid_options = (1..num_options).to_a
        if valid_options.include?(input.to_i)
            valid_input = input
        else
            puts "Please enter a number from the list."
            number_input_validator(num_options)
        end
    end

end