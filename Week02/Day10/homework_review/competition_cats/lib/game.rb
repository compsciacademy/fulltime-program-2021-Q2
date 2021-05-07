class Game
    attr_reader :game
    def initialize(player_1, player_2, game_type="competition")
        @player_1 = player_1
        @player_2 = player_2
        @game = game_type == "competition" ? Competition.new(player_1, player_2) : Playfight.new(player_1.cat, player_2.cat)
    end
end
