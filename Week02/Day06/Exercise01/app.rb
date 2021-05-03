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
