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
@computer_player = nil

def get_player
    if @players.empty?
        puts "No current players saved..."
        @player = create_player
    else
        @player = select_or_create_player
    end
end

def create_player
    puts "New Player name: "
    name = gets.chomp
    if name_exists? name
        puts "Name: '#{name}' taken. Try again."
        create_player
    else
        @player = Player.new(name)
        @players << @player
        return @player
    end
end

def player_names
    names = []
    @players.each do |player| 
        names << player.name 
    end
    names
end

def select_player
    puts "Select a player by name: "
    names = player_names
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
    else
        puts "unrecognized user: #{user_input}"
        select_or_create_player
    end
end

def select_competition
    puts "select 'r' for race or 'p' for playfight:"
    case gets.chomp
    when 'r'
        compete('race')
    when 'p'
        compete('playfight')
    else
        puts 'unrecognized command'
        select_competition
    end
end

def determine_winner(player, computer_player, competition_type='race')
    return [player, computer_player].sample
end

def compete(competition_type)
    winner = determine_winner(@player, @computer_player, competition_type)
    outcome = ["won", "lost", "tied"].sample
    case outcome
    when "won"
        puts "#{winner.name} #{outcome} the #{competition_type}!"
    when "lost"
        puts "#{winner.name} #{outcome} the #{competition_type}!"
    when "tied"
        puts "The #{competition_type} is #{outcome}!"
    end
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
    if @computer_player.nil?
        @computer_player = Player.new("ComputerMan")
    end

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
