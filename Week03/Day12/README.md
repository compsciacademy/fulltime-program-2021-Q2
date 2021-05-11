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

