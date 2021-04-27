
class Person
    # constructor
    def initialize(n)
        @name = n
    end
    
    # getter
    # attr_reader :name
    def name
      @name
    end
    
    # setter
    # attr_writer :name
    def name=(n)
        @name = n
    end
end

class Person
    attr_accessor :name, :email
    attr_reader :id
    
    def initialize(name)
        @name = name
    end
end

class Car
    attr_reader :brand, :model, :year
    attr_accessor :color, :price
    
    def initialize(brand, model, year)
        @brand, @model, @year = brand, model, year
    end

    def start
        puts "Starting engine..."
    end

    def accelerate
        puts "Starting to accelerate..."
    end

    def slow_down
        puts "Slowing down..."
    end

    def stop
        puts "Stopping..."
    end

    def turn_off
        puts "Turning off.."
    end
end

class Monster
    def attack(prey)
        # calculate the energy required based on prey speed
        # calculate 
    end
end

class Prey
    attr_reader :speed
    def initialize(speed)
        @speed = "medium"
    end
end


mean_monster = Monster.new

chicken = Prey.new

p1 = Person.new("Joe")
p2 = Person.new("Gary")
p3 = Person.new("Stacey")
puts p1.name
puts p2.name
puts p3.name

p1.name = "Joseph"
puts p1.name
