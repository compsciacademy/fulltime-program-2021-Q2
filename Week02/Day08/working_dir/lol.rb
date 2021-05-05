
class CannotEatFoodError < StandardError
end

class Food
    attr_accessor :calories
end

class CatFood < Food
    def is_catfood?
        return true
    end
end

class Cat    
    # ...
    def eat(food)
        food.calories
    end
end

kitty = Cat.new
catfood = CatFood.new

# puts catfood.is_catfood?

begin
    kitty.eat("lol")
rescue StandardError => e
    puts "Just rescued this error, fyi: #{e.message}"
end
