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
