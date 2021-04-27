
def add_place(country)
    puts "enter #{country}'s province or state:"
    state_input = gets.chomp
    puts "Please enter #{state_input}'s capital:"
    capital_input = gets.chomp
    # return [country, state_input, capital_input]
    [country, state_input, capital_input]
end

def list_places(places)
    if places.empty?
        puts "There are not places, yet."
    elsif
        places.each_with_index do |place, idx|
            puts "Country: #{place[0]}"
            puts "State: #{place[1]}"
            puts "Capital: #{place[2]}"
        end
    end
end

def run
    places = []
    while true do
        puts "Press 'c' to add place, 'l' to list, or 'q' to quit"
        user_input = gets.chomp
        break if user_input == 'q'
        if user_input == 'c'
            puts "Enter name of Country"
            country_input = gets.chomp
            places << add_place(country_input)
        elsif user_input == 'l'
            list_places(places)
        end
    end
end

run
