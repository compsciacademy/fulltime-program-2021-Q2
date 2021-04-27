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
