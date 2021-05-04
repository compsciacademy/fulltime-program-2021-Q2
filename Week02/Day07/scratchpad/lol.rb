class Cat
    attr_reader :name, :size, :agility, :strength, :confidence
    attr_accessor :wins, :losses, :energy

    def initialize(name)
        @name = name
        @size = ['small', 'medium', 'large'].sample
        @energy = 100
        @wins = 0
        @losses = 0
        @confidence = confidence
        @agility = agility
        @strength = strength
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

class Playfight
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

cat1 = Cat.new("Christian's Cat")
cat2 = Cat.new("Drew's Cat")

times = 10
while times > 0 do
    playfight = Playfight.new(cat1, cat2)
    playfight.compete
    times -= 1
end

puts cat1.to_s
puts cat2.to_s

