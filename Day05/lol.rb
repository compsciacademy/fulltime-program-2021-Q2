
class Person
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def greet
        "Hello! My name is #{self.name}!"
    end

    def number_of_hands
        2
    end
end

class User < Person
    def initialize(email)
        @email = email
    end

    def greet
        "lol what????"
    end
end

u = User.new "drew@gmail.com"
p = Person.new "Herb"
puts u.greet
puts p.greet

puts u.number_of_hands
