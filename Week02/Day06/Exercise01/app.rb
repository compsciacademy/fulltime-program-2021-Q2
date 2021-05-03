# My Shopping List Application
#
# An application for me to create 
# shopping lists that I can use
# myself.
#

class CLI
    def self.run
        menu = "My Shopping List Application\n\nq  quit this program\na  a to list\nr  read list\n\n"
        puts menu
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
    end

    def self.add_to_list
        puts "creating list..."
        while true do
            print "enter an item (or press 'q' to finish): "
            user_input = gets.chomp.downcase
            break if user_input == 'q'
            MY_LIST << user_input
        end
    end

    def self.read_list
        if MY_LIST.empty?
            puts "The list is empty"
            return
        end
        puts MY_LIST
    end
end


class ShoppingList
    attr_reader :items

    def initialize
        @items = []
    end

    def add(item)
        @items << item
    end

    def read
        @items
    end
end

class App
    def self.run
        CLI.run
    end
end

App.run
