#  Define the properties, attributes, methods, 
#  etc. for Ball and Ghost classes. Then write
#  a program that instantiates at least 2 of each.

# Ball: properties, attributes, methods
# Ball can be either "regular ball" or "super ball"
class Ball
    attr_reader :ball_type
    def initialize(ball_type='regular', point_value=1)
        # @ball_type = ['regular', 'super'].include?(ball_type) ? ball_type : 'regular'
        @ball_type = ball_type
        @point_value = point_value
    end

    # should a ball care where it is?
    # def x_position; end
    # def y_position; end
    # def position
    #     {
    #         :x => @x_position, 
    #         :y => @y_position
    #     }
    # end
end

# Ghost: properties, attributes, methods
# N number of ghosts can have different colors, so
# a property would be color.
class Ghost
    attr_reader :speed
    initialize; end

    def move(direction, spaces)
        # ... 
    end
end

# Instantiate some objects
rb1 = Ball.new
rb2 = Ball.new

sb1 = Ball.new 'super'
sb2 = Ball.new 'lolzor' # should be ?
sb3 = Ball.new 1 # should be ?

rb3 = Ball.new('regular')
sb4 = Ball.new('super')

balls = [rb1, rb2, sb1, sb2, sb3, rb3, sb4]

balls.each_with_index do |ball, index|
    puts "Ball ##{index + 1} is of type '#{ball.ball_type}.'"
end


# Example game board
# game_board = [
# [[], [], [], [], []], 
# [[], [x], [], [x], []], 
# [[], [], [], [], []], 
# [[], [x], [], [x], []], 
# [[], [], [], [], []],
# ]


class Game
    def initialize(game_board, pacman, ghosts)
    end

    def start_game; end
    def pacman_position; end
    def turn 
        @pacman.move
        ghosts.each do |ghost|
            if ghost.alive?
                ghost.move
            end
        end
    end
end
