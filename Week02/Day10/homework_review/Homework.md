# Homework Review from Day 09  
  
Looking at what we discussed today, look back at the game of Competition Cats. Think about what some of the objects in the game are, and how we might write tests, and use those tests to write code for those objects and their behavior.  
  
Try to implement the following classes: Cat, Competition, Game, Player. As well as any peripherals that may be be needed to support those classes.  
  
An end goal to have in mind can be, a game where 2 players enter a cat each into a competition.  
  
```ruby

module MyTest
    def self.expect_equal(actual, expected)
        if actual == expected
            puts "PASS"
        else
            puts "FAIL\nExpected: #{expected}\nActual: #{actual}\n"
        end
    end
end

class Cat
    attr_reader :name, :size, :agility, :strength, :confidence
    attr_accessor :wins, :losses, :energy, :tally

    def initialize(name)
        @name = name
        @size = ['small', 'medium', 'large'].sample
        @energy = 100
        @wins = 0
        @losses = 0
        @confidence = confidence
        @agility = agility
        @strength = strength
        @tally = 0
    end

    def agility
        base = 50
        case size
        when 'small'
            bonus = 50
        when 'medium'
            bonus = 25
        when 'large'
            bonus = 0
        end
        @agility = base + bonus
    end

    def strength
        base = 50
        case size
        when 'large'
            bonus = 50
        when 'medium'
            bonus = 25
        when 'small'
            bonus = 0
        end
        @strength = base + bonus
    end

    def confidence
        # scale from 1 to 100
        base = 50
        current_confidence = base + (@wins * 2) - (@losses * 2)
        if current_confidence > 100
            return 100
        elsif
            current_confidence < 1
            return 1
        else
            current_confidence
        end        
    end

    def to_s
        "name: #{@name}, size: #{@size}, energy: #{@energy}, agility: #{@agility}, strength: #{@strength}, confidence: #{@confidence}, wins: #{@wins}, losses: #{@losses}"
    end
end

class Player
    attr_accessor :name, :cat

    def initialize(name, cat=nil)
        @name = name,
        @cat = cat==nil ? nil : Cat.new(cat)
    end

    def has_cat?
        if @cat == nil
            return "Player has no cat"
        else
            return "Player has selected cat"
        end
    end

    def player_cat
        puts cat.to_s
    end
end

class Game
    attr_reader :game
    def initialize(player_1, player_2, game_type="competition")
        @player_1 = player_1
        @player_2 = player_2
        @game = game_type == "competition" ? Competition.new(player_1, player_2) : Playfight.new(player_1.cat, player_2.cat)
    end
end

class Playfight
    attr_accessor :cat1, :cat2
    def initialize(cat1, cat2)
        @cat1, @cat2 = cat1, cat2
    end

    def chance_to_win(cat)
        luck = [1, 250, 500, 750, 1000].sample
        points = ((cat.strength + cat.agility) * cat.confidence) + (luck * 10)
    end

    def compete
        cat_1_chance_to_win = chance_to_win(@cat1)
        cat_2_chance_to_win = chance_to_win(@cat2)

        if cat_1_chance_to_win > cat_2_chance_to_win
            @cat1.wins += 1
            @cat2.losses += 1
            return "#{@cat1.name} wins!"
        elsif cat_1_chance_to_win < cat_2_chance_to_win
            @cat2.wins += 1
            @cat1.losses += 1
            return "#{@cat2.name} wins!"
        else
            return "it's a tie!!!"
        end
    end
end

class Competition
    attr_accessor :player_1, :player_2

    def initialize(player_1, player_2)
        @player_1 = player_1
        @player_2 = player_2
    end
end

class Againstmice
    attr_accessor :tally, :cat1, :cat2
    
    def initialize(cat1, cat2)
        @cat1, @cat2 = cat1, cat2
        @tally = 0
    end
    
    def spawn
        mice = []
        count = 100
        while count > 0 do
            agility = rand(1..100)
            if agility < 100 && agility > 85
                mice << 3
            elsif agility < 85 && agility > 60
                mice << 2
            else
                mice << 1
            end
            mice
            count -= 1
        end
        mice
    end
    
    def comp(*tally)
        @tally = 0
        mice1 = spawn
        mice2 = spawn
        mice1.zip(mice2).map do |x, y|
            if x > y    
                puts "Cat caught mouse!" 
                @tally += 1
            else
                puts "Mouse ran away!"
            end
        end
        @tally
    end
    
    def results
        puts cat_1_chance_to_win = comp(@cat1)
        puts cat_2_chance_to_win = comp(@cat2)
        
        if cat_1_chance_to_win > cat_2_chance_to_win
            puts "Cat 1 wins, Cat 2 looses"
        else
            puts "Cat 2 wins, Cat 1 looses"
        end
    end
end

def test_player_setup
    # Profile setup: two players - one with cat, one without
    puts "======TEST PLAYER SETUP======"
    player_profile_1 = Player.new("Christian", "meow master")
    player_profile_2 = Player.new("Lee")
    puts "EXPECTED TO PASS: "
    MyTest.expect_equal(player_profile_1.has_cat?, "Player has selected cat")
    puts "EXPECTED TO FAIL: "
    MyTest.expect_equal(player_profile_2.has_cat?, "Player has selected cat")
end



def test_competition
    # Starts new game (Competition) with player 1, player 2, arg. to denote game type
    puts "======TEST COMPETITION======"
    player_profile_1 = Player.new("Christian", "meow master")
    player_profile_2 = Player.new("Lee", "Lee's cat")
    game_instance = Game.new(player_profile_1, player_profile_2, "competition")
    puts "Is ln. 212 game_instance running an instance of Competition?"
    puts game_instance.game.instance_of?(Competition)
end


def test_playfight
    # Starts new game (Playfight) with player 1, player 2, arg. to denote game type
    puts "======TEST PLAYFIGHT======"
    player_profile_1 = Player.new("Christian", "meow master")
    player_profile_2 = Player.new("Lee", "Lee's cat")
    game_instance2 = Game.new(player_profile_1, player_profile_2, "Playfight")
    puts "Should print out result of Playfight."
    puts game_instance2.game.compete
end

def test_class_competition
    puts "=====TESTING COMPETITION CLASS========"
    cat1 = Cat.new("Meowmaster")
    cat2 = Cat.new("Catnip_lover")

    new_competition = Competition.new(Player.new("christian", "Meowmaster"), Player.new("someone", "Catnip_lover"))

    puts "Tests Competition Player #1's Cat's name: \n"
    puts "EXPECTED TO PASS:\n"
    MyTest.expect_equal(new_competition.player_1.cat.name, cat1.name)
    puts "EXPECTED TO FAIL:\n"
    MyTest.expect_equal(new_competition.player_1.cat.name, cat2.name)
end

def run
  test_player_setup
  test_playfight
  test_competition
  test_class_competition
end

run

```