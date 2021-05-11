# Day 12

## Exercise 01  
  
There is a file called [`main.rb`](https://replit.com/@DrewOgryzek/LolPerson) with the following:  
```ruby
require './person'

names = ['Sandy', 'Corey', 'Tyler', 'Bo', 'Chris', 'Shell']

names.each { |name| Person.new(name).save }

Person.all.each do |person|
  person.greeting = ["I like milk.", "Potato is my name friend", "Don't worry about candy face.", "Some salad is vegan.", "Do it or do not, but don't wait!", "What is the way to the place?", "Who said, 'Hey there! Hi... and then something?'"].sample
  person.save
end

Person.all.each do |person|
  person.greet do |name, greeting|
    puts "Harry: Hi! I am Harry. How are you? What's your name?"
    puts "#{name}: #{greeting}"
  end
end
```

Your mission, should you choose to accept it, is to write a class `Person` that can be required in the above file, that satisfies the requirement of making it work.  

```ruby
# person.rb

class Person
  attr_reader :name
  attr_accessor :greeting
  @@people = {}

  def initialize(name)
    @name = name
  end

  def save
    @@people[self.name] = self
  end

  def greet
    yield(@name, self.to_s)
  end

  def self.all
    people_objects = []
    @@people.each do |k, v|
      people_objects << v
    end
    people_objects
  end

  def to_s
    "My name is #{@name}! #{@greeting}"
  end
end
```

## Exercise 02  
  
This time, let's build out a Pacman-like game. First, let's think through some of the objects we might have, how they might interact, and what other things may be necessary.  
  
Pacman eats balls. There are two types of balls, regular balls which just count as single unit points. All regular balls on a board must be consumed for the board to be cleared.  

There are super balls, or balls that when consumed cause Pacman to be able to consume ghosts for a limited amount of time. Consuming ghosts gives Pacman points. The ghosts respawn after they are consumed.
  
There are up to N number of ghosts (how many?) on a board. Ghosts come in a variety of colors. Do the colors have any special attributes or properties? Do ghosts have any abilities other than to move around on the board?  
  
Thinking through this, it's pretty obvious that balls, ghosts, and pacman could be objects. There may also be some other objects (or at least classes) to be instantiated for a game, but let's start here.  
  
**Part a.)**  

Define the properties, attributes, methods, etc. for Ball and Ghost classes. Then write a program that instantiates at least 2 of each.  
  
```ruby
class Ball; end
class Ghost; end
```
