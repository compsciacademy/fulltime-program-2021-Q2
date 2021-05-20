# Prompt a user for username and password
# if it is correct, they can login. Otherwise,
# they cannot.
#
# Prerequisites: Must be able to create a user
# with a password.
require './user'

class App
  attr_reader :current_user, :session

  def menu
<<-MENU
USER APPLICATION
================

M,H  View this menu
N    New User
L    Log in
O    Log out
Q    Quit

MENU
  end

  def run
    @session = {}
    puts "Welcome to USER APPLICATION\n" \
    "What would you like to do?\n" \
    "#{menu}"

    loop do
      if @session['user']
        puts "CURRENT USER: #{@session['user'].email}"
      else
        puts "Create a new user or login to be greeted"
      end
      user_input = gets.chomp.downcase
      case user_input
      when 'q'
        break
      when 'n'
        puts "Email address: "
        email = gets.chomp
        puts "Password: "
        password = gets.chomp
        user = User.new(email, password)
        if user.save
          puts "User saved!"
        else
          puts "Something went wrong"
        end
      when "l"
        puts "Email address: "
        email = gets.chomp
        puts "Password: "
        password = gets.chomp
        session['user'] = User.login(email, password)
      when 'o'
        session['user'] = nil
      when 'm', 'h'
        puts menu
        next
      else
        puts "Unrecognized command: #{user_input}\n\n"
        puts menu
      end
    end
  end
end

App.new.run
