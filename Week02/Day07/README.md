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