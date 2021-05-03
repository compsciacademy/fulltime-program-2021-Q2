class Animal
    attr_reader :description

    def self.describe
        puts "I am a clean animal."
    end

    def initialize(species)
        @description = "I am a(n) #{species}."
    end

    def describe
        self.description
    end
end

a = Animal.new("Alpaca")
b = Animal.new("Anole lizard")
c = Animal.new("Armadillo")

puts a.describe
puts b.describe
puts c.describe

class Person < Animal
    def self.describe
        puts "I am a dirty animal!"
    end
end

p = Person.new("Homo Sapiens Sapiens")
puts p.describe

def describe
    puts "I am describing something here."
end

describe
Animal.describe
Person.describe
