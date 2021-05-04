class Recipe
    attr_reader :ingredients

    def initialize(*ingredients)
        @ingredients = ingredients.flatten
    end
end

salad = Recipe.new("lettuce", "beef chunks", 'gravy', 'sour cream', 'pineapples', 'raisons', 'cherries', 'tangerines', 'tomotoes')

puts salad.ingredients.to_s
