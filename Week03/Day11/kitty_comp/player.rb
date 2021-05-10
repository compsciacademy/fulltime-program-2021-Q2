class Player
    def initialize(name)
        @name = name
    end

    def save
        true if @name == "Drew"
    end
end