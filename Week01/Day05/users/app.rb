require './user'

# prompts a user to create, update (edit) or list users.
MENU = <<-menu

User Program
============

Commands:
q  quit the program
l  list all users
c  create a user
u  update a user
h  prints this menu

menu

def run
    puts MENU

    while true do
        puts "Input a command: "
        user_input = gets.chomp

        case user_input
        when 'q'
            break
        when 'h'
            puts MENU
        when 'l'
            users = User.all
            users.each do |user|
                puts "Name: #{user.name}"
                puts "Email: #{user.email_address}"
                puts "-----------------------------"
            end
        when 'c'
            puts "Enter user name: "
            name = gets.chomp
        
            puts "Enter user email address: "
            email_address = gets.chomp
        
            create_user(name, email_address)
        when 'u'
            puts 'update user'
        else
            puts "I don't know what to do..."
        end
    end 
end

run 