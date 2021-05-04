
module Greetings
    def self.greet
        ['hello', 'hi', 'hey', 'yo'].sample
    end
end

class Person
    def greet
        Greetings.greet
    end
end

p  = Person.new
puts p.greet
