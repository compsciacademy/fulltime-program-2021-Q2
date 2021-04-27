# Day 02 -- More Ruby

Let's take a look at iterating over arrays in Ruby! 

```ruby
colors = ["red", "orange", "yellow", "blue", "green", "purple", "indigo", "violet"]

colors.each do |color|
    puts color
end

colors.each { |color| puts color }

# non destructive without a !
colors.each { |color| puts color.capitalize }

# using the ! will replace the items in the array
colors.each { |color| puts color.capitalize! }

colors.each_with_index do |color, i|
  puts "#{i}: #{color}"
end
```

## Functions

Sometimes (often), you will have some functionality in code that you may wish to repeat. Using a function or method is a great way to do that. Usually, we call a function that is attached to an object a method. In Ruby, since everything is an object, it's conventional to call all functions methods.

```ruby
def greet
    puts "Hello there friends!"
end

def greet
    puts "Hello there friends!"
end

3.times do 
    greet
end

def greet(name)
    puts "Hello there #{name}!"
end

names = ['Christian', 'Drew', 'Tracy', 'Michelle']

names.each { |name| greet name }

greet 'Christian'

```

## Exercise 01

Let's rewrite our solution to yesterday's family member program, such that it will continue to prompt a user for input until the user enters 'q'.

Here was one possible solution to yesterday's exercise:
```ruby
puts "How many family members do you have?"
family_member_count = gets.to_i
family_members = []

while family_member_count > 0 do
    family_member_count -= 1
    puts "Enter family member's full name:"
    full_name = gets.chomp
    puts "Enter family member's preferred name:"
    preferred_name = gets.chomp
    # family_member = "Full Name: #{full_name}, Preferred Name: #{preferred_name}"
    family_member = [full_name, preferred_name]
    family_members.push(family_member)
end

# puts family_members
family_members.each do |member|
    puts "Full Name: #{member[0]}, Preferred Name: #{member[1]}"
end
```

Here's a bit of a start to get you thinking
```ruby
# a family member has 2 attributes:
# full name, e.g.: "James Andrew Warren Ogryzek"
# preferred name, e.g.: "Drew"
# How should we represent a single family member?
# 
# member = ["full name", "preferred name"]
#
# members = [member1, member2, member3], etc...
#
# members = [
#     ["full name 1", "preferred name 1"], 
#     ["full name 2", "preferred name 2"]
# ]
#

family_members = []
# How are we going to collect information about family members?
#
# For each family member, we need to collect 2 values:
#  - full name
#  - preferred name
#
# And we want to store each member in the list of family members
#
# Let's prompt a user to enter a family member or quit

# puts "Press 'e' to enter a family member, or press 'q' to quit:"

# while true do
#     user_input = gets.chomp
#     if user_input == 'q'
#         break
#     elsif user_input == 'e'
#         puts "Enter family member's full name:"
#         full_name = gets.chomp
#         puts "Enter family member's preferred name:"
#         preferred_name = gets.chomp
#         puts "Entered: Full Name: #{full_name}, Preferred Name: #{preferred_name}"
#         puts "Press 'e' to enter another family member, or press 'q' to quit:"
#         user_input = gets.chomp
#         if user_input == 'e'
#             next
#         else
#             break
#         end
#     end
# end


```

Example of a possible solution to exercise 01:
```ruby
FAMILY_MEMBERS = []

def add_family_member(full_name)
    puts "Enter #{full_name}'s preferred name: "
    user_input = gets.chomp
    if user_input == 'q'
        return
    else
        FAMILY_MEMBERS.push([full_name, user_input])
    end
end

def list_family
    FAMILY_MEMBERS.each do |member|
        puts "Preferred Name: #{member[1]}"
        puts "Full Name: #{member[0]}"
    end
end

while true
    puts "Enter a family member's full name, 'l' to list the family or 'q' to quit"
    user_input = gets.chomp
    if user_input == 'q'
        break
    elsif user_input == 'l'
        list_family
    else
        add_family_member user_input
    end
end
```

## Hashes

In Ruby, the Hashmap data structure is called a hash, and is quite useful! Let's work with hashes!

```ruby
family_member = {full_name: "Here is my full name", preferred_name: "Here is 
my perferred name" }

family_member[:full_name] = "James Andrew Warren Ogryzek"
family_member[:preferred_name] = "Drew"

family_member.each do |k, v|
    puts "key: #{k}, value: #{v}"
end

```

## Exercise 02

Create a program that asks a user to input a country's name. Then asks whether the country has state, provinces or other, and asks for a list of them.

For each item in the list of states, provinces or others, it asks for a capital.

Finally, it should be able to print out the country with each state, province or other, and its capital, e.g.

Country: Canada
British Columbia: Victoria
Alberta: Edmonton
Etc...

Possible Solution #1

```rb

# let's think through what information we might have for each 
# country. We can assume that we have a list (array) of countries.
countries = [
    {
        name: "Canada",
        state_province_other: "province",
        capital: "Ottawa",
        states: [
            {
                name: "British Columbia",
                capital: "Victoria"
            },
            {
                name: "Alberta",
                capital: "Edmonton"
            },
            {
                name: "Ontario",
                capital: "Toronto"
            }
        ]
    },
    {
        name: "Japan",
        state_province_other: "prefecture",
        capital: "Tokyo",
        states: [{}]
    },
    {},
    {}
]

countries << new_country
# Country Information:
# Name: Canada
# Capital: Ottawa
# Provinces: 
#   Alberta: Edmonton
#   British Columbia: Victoria
#   Ontario: Toronto
#
# Name: United States of America
# Capital: Washington DC
# States:
#  Washington: Olympia
#  Oregon: Salem
#
# Name: Japan
# Capital: Tokyo
# Prefectures:
#   Kanagawa-ken: Yokohama-shi
#   Osaka-fu: Osaka-shi
#   Hyoko-ken: Kobe-shi
# 

```

## Classes

A class is sort of a blueprint for an object. Some people think of them as factories. Let's take a look at some classes in Ruby.

```ruby
class Person
    # constructor
    def initialize(name)
    end
    # getter
    # setter
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

```

## Exercise 03

a.) Create a class for computer objects. Computers should have a brand, be laptops or desktops, have ages (or dates of production), and new sales prices.

b.) Add a method on computers to calculate a used sales price based on new sales price, age, and whether it is a desktop or laptop.

