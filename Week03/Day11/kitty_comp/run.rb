# Main entry point for our Kitty Comp game!
require './player'

class App
    # whatever configuration, etc. is needed can be loaded or
    # defined here. For now, this may just be an empty class that 
    # runs the game.
    def run
        start
    end

    def start
        menu = <<-MENU
Kitty Comp -- The Fresh New Game!

N  New Player
F  Find Player

Press Q to Quit or make a selection to Start Game!
        MENU

        puts menu
        loop do
            user_input = gets.chomp.downcase
            case user_input
            when "q"
                break
            when "n"
                create_player
            when "f"
                find_player
            else
                next              
            end
        end
    end

    def create_player
        puts "New player name: "
        name = gets.chomp
        puts "creating a new player..."
        puts "return player: #{name}"

        # loop do
        #     puts "New player name: "
        #     name = gets.chomp
        # end
    end

    def find_player
        # If not, you are told that there is no player 
        # by that name, and prompted to select whether 
        # to find or create a player.
        puts "Find player name: "
        name = gets.chomp
        @player = (name == "Drew" ? "Drew" : nil)
        puts "finding player"
        if @player
            puts "Found player..."
            puts "return payer: #{name}"
        else
            puts "Player not found"
            find_or_create_player
        end
    end

    def find_or_create_player
        loop do
            puts "F  Find player"
            puts "N  New player"
            user_input = gets.chomp.downcase
            case user_input
            when "f"
                find_player
            when "n"
                create_player
            else
                break
            end
        end
    end
end

app = App.new
puts app.run
