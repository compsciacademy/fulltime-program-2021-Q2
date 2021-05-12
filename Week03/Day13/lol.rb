class Greeting
    def initialize(greeting)
        @greeting = greeting
    end

    def self.greet
        "Greetings!"
    end

    def greet
        @greeting
    end
end

puts Greeting.greet

g = Greeting.new("I am an instance vaiable!")

puts g.greet


