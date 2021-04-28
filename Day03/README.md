# Ruby Continued...

Today, we're going to be discussing more about Classes, OOP, some Algorithms and Data Structures... and some review of what we've already covered.

## Review of some Data Types

```ruby
# strings
name = "Drew Ogryzek"
greeting = "Hello there, #{name}!"

# integers
a = 1
b = 5

a > b # false
b <= a # false
b > a # true

# array
colors = ["yellow", "blue", "orange", "pink"]

# hash
schedule = {"monday": "Go to the park", "tuesday": "Swim in the pond", "wednesday": "Fly a kite"}

recipies = {"cakes": {"black forest": [{"recipe 1": "..." }, {"recipe 2": "..."}]}}

recipe = {
    "name": "french toast",
    "ingredients": ["bread", "eggs", "milk"],
    "method": {"step 1": "...", "step 2": "..."}
    "to_string": ""
}

# class
class Cup
    attr_reader :size, :color, :material
    def initialize(size, color, material)
        @size, @color, @material = size, color, material
    end
end

mug = Cup.new("16 oz", "gray", "porceline")
```

## Review of Loops & Control Flow

```ruby
count = 0
while true do
    count += 1
    puts "hello"
    break if count > 3 # a way to stop the loop
end

10.times do
    puts "Hello there"
end

[1, 2, 3, 4].each do |n|
    puts n
end

[1, 2, 3, 4].each { |n| puts n }

# if, elsif, else
num = [1, 2, 3, 4].sample
if num == 1 
    puts "You win!"
elsif num == 4
    puts "Pay 10x"
else
    puts "You lose!"
end

count = 0

while true do
    puts "Give me a number: "
    num = gets.to_i
    count += num
    break if count > 50
end

puts count
```

## Functions

Exercise 01

a.) Write a function that takes a list of numbers and returns that list of numbers sorted from smallest to largest.

b.) Write another function that takes a list of letters and returns that list of letters sorted alphabetically.

```ruby
def sort_num_list(numbers)
    numbers.sort
end

def sort_letter_list(letters)
    letters.sort.reverse
end

nums = [52, 12, 123, 32132, 3, 64, 432]

letters = ['a', 'z', 'o', 'b', 'c', 'q']

puts sort_num_list(nums)

puts sort_letter_list(letters)
```

Exercise 1.5

Create a class with a constructor that verifies that a given parameter is an array.

```ruby
class Person
    attr_accessor :friends
    attr_reader :name

    def initialize(name, friends)
        # verity that friends is an array
        unless friends.is_a? Array
            raise "Expecting an Array, got: #{friends.class}"
        end

        @name = name
        @friends = friends
    end
end

p = Person.new("Drew", ["hahahaha"])

puts p
puts p.name
puts p.friends
```

Exercise 02

Write a function that prints a triangle shape to STD Out, using 0s. It should accept an argument. The argument accepted is an integer and represents the number of rows in the triangle.

```ruby
# e.g. 

triangle(2)

  0
 0 0

triangle(3)

   0
  0 0
 0 0 0
```

## Review

```ruby

class Country
    attr_reader :country
    attr_accessor :cities

    def initialize(country, cities=[])
        @country = country
        @cities = cities
    end

    # setter
    def capital=(capital)
        @capital = capital
    end

    # def cities=(cities)
    #     @cities = cities
    # end
end

class City
    attr_accessor :population
    attr_reader :name

    def initialize(name)
        @name = name
    end
end

class Province; end
class State; end
class Prefecture; end
class Other; end

c = Country.new("Canada", [City.new("Vancouver")])
ottawa = City.new("Ottawa")
ottawa.population = 1,500,000
c.capital = ottawa
c.cities << ottawa
```

# Exercise 03

Let's think through an exercise where we start to develop objects for a game. This game is a game of cats and birds. Cats have various attributes, and birds have various attributes.

Cats hunt birds, capture birds, can store birds in bags. They also have energy, and some other attributes.

We will need to think through several things that are applicable to how our game will work, what attributes objects should have, how they are relevant and how interaction will occur (and affect their attributes).

For now, let's think about this:

Cats have bags. Bags have sizes. Bags can hold birds.

Cats catch birds, and put them into their bags to store for later.

Birds have sizes. The amount of space in a bag that a bird occupies depends on the size of the bird.

All of these objects must have more attributes and be able to perform more actions than we have described so far, but we will deal with that later.

For now, let's just work on creating Cat, Bird, and Bag objects that satisfy the conditions discussed.

```ruby
# Cats
#  - have bags
#  - catch birds
#  - put bird into bag
#    + store for later*
class Cat
    # do all cats have bags?
    # does one cat have one bag or many?
    #  - how does this work?
    
    # NOTE: What criteria matters for catching
    # a bird?
    # TODO: ensure that objects being caught are
    # indeed birds.
    def catch(bird)
        # if everything is good
        # we have a bird object, then
        store bird
    end

    # We will want to store a bird in a bag
    # How many bags do we have? 1 or n? If n,
    # how do we determine which bag? If 1,
    # we need to see if the bird will fit
    # Anything else?
    def store(bird)
    end
end

# Birds
#  - have a size
class Bird
    attr_reader :size

    def initialize(size)
        @size = size
    end
end

# Bags
#  - hold birds
#  - how many birds depends on bird size
class Bag
    def initialize
        birds = []
    end

    # NOTE: we should maybe check to make sure
    # that we are only accepting birds. Maybe?
    # 
    # We don't know the size-constraints. We need
    # to figure that out, or make a decision, or...
    # do nothing.
    #
    # TODO: Create a list of questions we need to 
    # have answered for us to implement the Bird
    # class.
    def add(bird)
        @birds << bird
    end
end

```

**Part B**

Create a list of questions we need answered before we can continue.