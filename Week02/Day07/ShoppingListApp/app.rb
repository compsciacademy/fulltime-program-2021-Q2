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

puts menu

while true do
    print 'enter a command: '
    user_input = gets.chomp.downcase
    case user_input
    when 'q'
        break
    when 'c'
        items = []
        while true do
            puts "add a shopping list item (press 'd' if done): "
            item = gets.chomp
            break if item == 'd'
            items << item
        end
        list = ShoppingList.new(items)
        if list.save
            puts "saved list ... "
        else
            puts "Something went wrong :("
        end
    when 'r'
        list = ShoppingList.read
        puts "#{list}"
    when 'u'
        puts "'a' to add an item"
        puts "'r' to remove an item"
        puts ""
        print "enter a command: "
        items = ShoppingList.read

        user_input = gets.chomp.downcase
        if user_input == 'a'
            puts "items: #{items}"
            puts "item to add: "
            item = gets.chomp
            items << item

            list = ShoppingList.new(items)
            if list.save
                puts "saved list ... "
            else
                puts "Something went wrong :("
            end
        elsif user_input == 'r'
            list = ShoppingList.read
          
            list.each_with_index do |item, i|
                puts "#{i}: #{item}"
            end

            puts "Which item would you like to remove?"
            remove = gets.to_i
            list.delete_at(remove)
            shopping_list = ShoppingList.new(list)
            shopping_list.save
        end

    when 'd'
        if ShoppingList.delete
            puts "deleted shopping list"
        else
            puts "Something went wrong"
        end
    else
        next
    end
end

