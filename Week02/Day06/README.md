# Day06 

We've worked so far, a little with CLI-based I/O, let's continue with that, and dive further into classes.

## Shopping List Application

Let's build out a shopping list application that allows a user to create a shopping list. Before we do this, we need to define what a shopping list is, how it behaves, and potentially some of our use cases for lists and for the application in general.  
  
Sample List

  * dish soap
  * potatoes
  * milk
  * paper towels
  * fabric softener
  * bananas
  * yogurt
  * eggs
  * toothpaste
  * hair brush

When we look at a list like this, we can see it's just a collection of household items, and there doesn't seem to be anything particularly special about them. However, there is some information that may be missing (on purpose or for another reason), for example how much of each item is required. Some of this may be common sense, some of it may be something that only makes sense to the person who created the list.

Example Use-Cases:

  * A person makes a list for themselves
  * An elderly person makes the list. A helper comes by once a week, takes the list, and goes shopping.
  * A grocery store picker uses lists to create packages for pick up
  * Other?


```ruby

# I might have some sort of user-interface that prompts a user for information:
#
#  My Shopping List App
#
#  (What are the use-cases? Who needs to interact with this application? What do they need to do?)

```


**Part II**

Some other use cases are that we want to be able to save lists, have list templates, somewhat generated lists (or really lists generated based on customer profiles).


More to come ...

---


## Exercise 01

Re-read the information we currently have about our shopping list. Create a couple of user profiles based on that information. Using those user profiles, create a couple of workflows, that is, explain in relative detail how they will interact with our system: What information will they put in, what information will they expect to get out, how will they use it?

a.) Create an application for a single user (you) that allows you to create and read a shopping list that you can use for shopping.


```ruby

# My Shopping List Application
#
# An application for me to create 
# shopping lists that I can use
# myself.
#

menu = <<MENU
My Shopping List Application

q  quit this program
a  a to list
r  read list

MENU
puts menu

MY_LIST = []

def add_to_list
    puts "creating list..."
    while true do
        print "enter an item (or press 'q' to finish): "
        user_input = gets.chomp.downcase
        break if user_input == 'q'
        MY_LIST << user_input
    end
end

def read_list
    if MY_LIST.empty?
        puts "The list is empty"
        return
    end
    puts MY_LIST
end

while true do
    print "enter a command: "
    user_input = gets.chomp.downcase

    case user_input
    when 'q'
        break
    when 'a'
        add_to_list
    when 'r'
        read_list
    else
        puts menu
    end
end

```

b) Expand that program to satisfy the conditions for the use cases outlined in your user workflows.