# Day 07

Let's take a look back at our Shopping List application, and dive into the world of CRUD (Create, Read, Update, Delete), as this is often said to be one of the most common sets of operations to perform on data.

We'll split our application, this time into 3 parts:

User Interface (CLI)
Application Layer (internal logic)
Data Store (file)

## Exercise 01

We have added some code to the `./ShoppingList` directory that satisfies the requirements for our CRUD application. That is, we are able to Create, Read, Update, and Delete a Shopping List.

Have a look at the code, and look for ways that it could be refactored (better organized/cleaned up/re-written to be _better_ in some manner).

```rb
# app.rb
require './shopping_list'

menu = <<MENU
My App

Commands

q  quit this application
c  create list
r  read list
u  update list
d  delete list

MENU

def prompt(message)
    puts message
    gets.chomp
end

def build_item_list
    items = []
    while true do
        item = prompt "add a shopping list item (press 'd' if done): "
        break if item == 'd'
        items << item
    end
    items
end

def update_list
    puts "'a' to add an item"
    puts "'r' to remove an item"
    puts ""
    user_input = prompt "enter a command: "
    items = ShoppingList.read

    if user_input == 'a'
        puts "items: #{items}"
        items << prompt("item to add: ")
        list = ShoppingList.new(items)
        list.save
    elsif user_input == 'r'
        list = ShoppingList.read
        list.each_with_index do |item, i|
            puts "#{i}: #{item}"
        end
        remove = prompt("Which item would you like to remove?").to_i
        list.delete_at(remove)
        
        ShoppingList.new(list).save
    end
end

puts menu

while true do
    user_input = prompt('enter a command: ')

    case user_input
    when 'q'
        break
    when 'c'
        items = build_item_list
        ShoppingList.new(items).save
    when 'r'
        puts "#{ShoppingList.read}"
    when 'u'
        update_list
    when 'd'
        ShoppingList.delete
    else
        next
    end
end

```

```rb
# shopping_list.rb
require_relative './datastore'

class ShoppingList
    attr_writer :items

    def initialize(items=[])
        @items = items
    end

    def save
        DataStore.open(@items.join(', '), 'w')
    end

    def self.read
        DataStore.open('').split(', ')
    end

    def self.delete
        DataStore.open('', 'w')
    end
end

```

```rb
#datastore.rb
module DataStore
    def self.open(data, method='r')
        File.open('shopping_list', method) do |file|
            case method
            when 'r'
                data += file.read
            when 'w'
                file.write(data)
            end
        end
        data
    end
end

```

## Exercise 02

Revisiting [Cats with Bags](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/master/Week01/Day03#exercise-03).

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

**The Game**

a.) Create a class for our game that will instantiate a competition. In this case, our competition type is cats competing to catch a bird. This means there are N number of competitors (cats), and there is 1 bird (bird).

The rules for the competition are left out in this case, but we will need to provide rules for how the game works, such that it can be played, and the cats can compete.

b.) Attributes! Cats and Birds should have some attributes. Some may be relevant for competition, others may not be. This doesn't have to be an exhaustive list of attributes, however, try to come up with a handful of attributes for each class that _is_ relevant for the competition.

Potential Attributes: agility, strength, health, energy, vitality, stamina, endurance, anger, intelligence, wisdom, age, compassion, dexterity, skill, drowsiness, happiness, confidence, vigor, fervor, experience, wins, losses, drive, motivation

Other Attributes: Name, Birthdate
Static Attributes/Base Attributes: agility, strength, energy, size
Dynamic Attributes/Derrived Attributes: wisdom, happiness, confidence, age
Stats: wins, losses


c.) Develop an algorithm for determining how a competition winner is selected, there are no winners.

Algorithm completion conditions:
  - a cat catches a bird (Winner is determined to be the cat)
  - an amount of time passes, and no cat has caught the bird (no winner)

Each time we check, or each step through the loop, we can do something. What are we going to do?

The bird can do something
Each cat can do something
The competition can do something (the environment can do something)

```ruby

while true do
    #What conditions will break this loop?


end

```




```ruby
competition_type = 'cats competiting to catch a bid'
bird = Bird.new # TODO: instantiate a bird or maybe this happens inside the competition
cats = [cat1, cat2, cat3, cat4] # however many cats...
competition = Competition.new(competition_type, cat1, cat2, cat3, cat4)


# a.) Create a class for our game that will instantiate a competition. In this case, our
# competition type is cats competing to catch a bird. This means there are N number of
# competitors (cats), and there is 1 bird (bird).
class Competition
    def initialize(competition_type, bird, *cats)
        @competition_type = competition_type
        @bird = bird
        @cats = cats.flatten
    end
end

```

d.) Let's side-shelf the above for now. We will come back to this set of problems after we have thought through and solved for some easier problems.

Let's create a new competition type, "Play Fighting." Cats can enter into a play fighting competition with each other.

Write an algorithm that determines the winner of a playfight between 2 cats, based on attributes you decide.

**Homework** 

Go back to c.) and work on your algorithm!
