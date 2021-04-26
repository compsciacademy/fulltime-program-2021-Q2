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

