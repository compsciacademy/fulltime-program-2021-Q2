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

