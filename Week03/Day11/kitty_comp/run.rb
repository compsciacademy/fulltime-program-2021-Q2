# **Start or Quit**  
#     We are prompted to start a game or quit the program.  

#   * **Quit**: Exits the program  
#   * **Start**: New Player or Select Player
#     * **Select Competition**: Race or Playfight
#     * **Compete**: Win, Lose, or Draw
#   * **Compete Again or Quit**: Repeat or Exit
class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end
end

@players = []
@player = nil

def get_player
    if @players.empty?
        @player = create_player
    else
        @player = select_or_create_player
    end
end

def create_player
    puts "New Player name: "
    name = gets.chomp
    if name_exists? name
        puts "Name taken. Try again."
        create_player
    else
        @player = Player.new(name)
        @players << @player
        return @player
    end
end

def select_player
    puts "Select a player by name: "
    names = []
    @players.each do |player| 
        names << player.name 
    end
    puts names

    name = gets.chomp
    if names.include? name
        @players.each do |player|
            if player.name == name
                return player
            end
        end
    else
        puts "Player '#{name}' not found."
        select_player
    end
end

def select_or_create_player
    puts "'s' select or 'c' create player:"
    user_input = gets.chomp.downcase
    case user_input
    when 's'
        return select_player
    when 'c'
        return create_player
    end
end

def select_competition
    puts "selecting competition..."
    puts "You #{["won", "lost", "tied"].sample}!"
end

def play_game
    get_player
    select_competition
end

def name_exists?(name)
    @players.each do |player|
        if player.name == name
            return true
        end
    end
    false
end

loop do
    if @player
        puts "Player1: #{@player.name}"
    end
    puts "'s' start or 'q' quit"
    user_input = gets.chomp.downcase
    if user_input == 'q'
        break
    else
        play_game
    end
end
