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
