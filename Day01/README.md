# Intro to Ruby

Let's look at a couple of ways to use Ruby on your computer.

1.) Create a file with a ruby extension and run it using the Ruby interpreter

```
echo 'puts "Hello, World!"' > hello.rb
ruby hello.rb
```
2.) Use the interactive Ruby interpeter, irb.

```
irb
> puts "Hello World!"
exit
```

## Variable Assignment

```ruby
a = 11
b = 5
a / b
2

a = 11.0
b = 5
a / b
=> 2.2

name = "Drew Ogryzek"

puts "Hello #{name}!"
```

We can use `gets` to take input from standard input. Keep in mind that this comes as a string with a trailing newline character `\n`.

To convert a string to an integer, we can use `.to_i`, which will return a number if found or 0.

Write a program that prompts a user for their first name and last name, then greets them.

```ruby
puts "What is your first name?"
first_name = gets.chomp

puts "What is your last name?"
last_name = gets.chomp

name = "#{first_name} #{last_name}"
greet = "Hello there,"

puts "#{greet} #{name}!"
```

Write a program that prompts a user to enter a couple of numbers, then outputs the sum of those numbers.

```ruby
puts "Give me a number: "
first_number = gets.to_i

puts "Give me a second number: "
second_number = gets.to_i

puts "sum: #{first_number + second_number}"
```

## if, elsif, else

```ruby
a = 10
b = 5

if a < b
  puts "yes"
else
  puts "no"
end

```

Exercise 01

Create a program that prompts a user for the year of their computer. If it is newer than 3 years old, tell them they are good to go, and if not, let them know they might want to upgrade soon.

```ruby

puts "Hold many years old is your computer?"
computer_age = gets.to_i

if computer_age < 3
    puts "Sounds good to me!"
else
    puts "Might be time for an upgrade!"
end

```

Exercise 02

Create a program that prompts a user for their name. Make sure to consider whether they have any middle names, and account for them all. The program should then greet the user by their full name.

```ruby
puts "What's your first name?"
first_name = gets.chomp

puts "Do you have any middle names? (yes/no)"
have_middle_names = gets.chomp

if have_middle_names == "yes"
    puts "What are your middle names? (leave blank if none)"
    middle_names = gets.chomp
end

puts "What is your last name?"
last_name = gets.chomp

if have_middle_names == "yes"
    name = "#{first_name} #{middle_names} #{last_name}"
else
    name = "#{first_name} #{last_name}"
end

greeting = "Hello there, #{name}!"
puts greeting

```

Exercise 03

Modify the program above to ask the user, in addition to their first, middle, and last names, which name is their preferred name, and then greet the user by their preferred name, and tell them their full name.

e.g.

Full Name: James Andrew Warren Ogryzek
Preferred Name: Drew
Output: "Hello Drew! Your full name is: James Andrew Warren Ogryzek."