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

Exercise 02a

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

Exercise 02b

Modify the program above to ask the user, in addition to their first, middle, and last names, which name is their preferred name, and then greet the user by their preferred name, and tell them their full name.

e.g.

Full Name: James Andrew Warren Ogryzek
Preferred Name: Drew
Output: "Hello Drew! Your full name is: James Andrew Warren Ogryzek."

Exercise 02c

Modify the program to ensure that the preferred name is part of the full name.

Look at the Ruby documentation to find any helpful [string methods](https://ruby-doc.org/core-3.0.0/String.html).

```ruby



```

---

## Loops

```ruby
counter = 10
while counter > 0 do
    counter -= 1
    puts "----"
end

while true do
    puts "Give me some input"
    user_input = gets.chomp
    if user_input == "q"
        break
    end

    puts "Your input was: #{user_input}"
end
```

Exercise 03

Prompt a user for the number of people in their family, and the full (and preferred) name of each of its members. Then list each member by preferred name and full name.

With the tools we have discussed so far, one way we could solve this problem is to set a maximum number of family members that our system will support, and hard code our system for that.

```ruby
puts "How many family members do you have?"
family_member_count = gets.to_i
# our program needs to accommodate up to 10 family members.
if family_member_count > 10
    puts "You have too many family members. Contact an administrator."
    return
    # do something here (i.e. explode!)
end

family_member_setup_count = family_member_count

while family_member_setup_count > 0 do
    if family_member_setup_count == 10
        # set up family member 10
        puts "What is the full name for family member 10?"
        family_member10_full_name = gets.chomp
        puts "What is the preferred name for family member 10?"
        family_member10_preferred_name = gets.chomp
        family_member_setup_count -= 1
    end
    if family_member_setup_count == 9
        # set up family member 9
        puts "What is the full name for family member 9?"
        family_member9_full_name = gets.chomp
        puts "What is the preferred name for family member 9?"
        family_member9_preferred_name = gets.chomp
        family_member_setup_count -= 1
    end

    # family_member1
    # family_member2
    # family_member3
    # family_member4
    # family_member5
    # family_member6
    # family_member7
    # family_member8
    # family_member9

    # ...

    if family_member_setup_count <= 8
        break
    end
end

family_member_report_count = family_member_count

while family_member_report_count > 0
    if family_member_report_count == 10
        puts "Family Member 10's Full Name: #{family_member10_full_name}"
        puts "Family Member 10's Preferred Name: #{family_member10_preferred_name}"
        family_member_report_count -= 1
    end
    if family_member_report_count == 9
        puts "Family Member 9's Full Name: #{family_member9_full_name}"
        puts "Family Member 9's Preferred Name: #{family_member9_preferred_name}"
        family_member_report_count -= 1
    end

    # family_member1
    # family_member2
    # family_member3
    # family_member4
    # family_member5
    # family_member6
    # family_member7
    # family_member8
    # family_member9

    # ...

    if family_member_report_count <= 8
        break
    end
end

```

With the current system, what sorts of attributes are important for a family member? We really only have two, don't we? Full name and preferred name. Storing those attributes as strings seems fairly reasonable.

What does a family member look like now?

Family Member:
  * full name
  * preferred name

So, that sort of works within our system.

---

We have already discussed and used loops. Can't we use a loop to construct a _list_ of family members? Sure! However... what is a list? And how do we construct one in ruby?

```ruby
family_member = []
family_member[0] = "James Andrew Warren Ogryzek"
family_member[1] = "Drew"

puts family_member.first
puts family_member.last

foods = []
foods[0] = ["nuts", "peanuts", "pine nuts", "cashews"]
foods[1] = ["fruit", "apples", "pears", "oranges"]
foods[2] = ["grain", "wheat", "rice", "barley"]

```

Keep working on the problem we solved above. Modify it such that it is able to accept a variable number of family members, and do not repeat yourself in the code as much (if possible).