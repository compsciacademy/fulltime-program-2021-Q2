def run
    puts "Starting up now..."
    while true do
        puts "enter q to quit"
        user_input = gets.chomp
        break if user_input == 'q'
    end
    puts "Shutting down..."
end

run
