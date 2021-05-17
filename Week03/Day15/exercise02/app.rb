
# Handle records of users 
# User Attributes: username, email address
# - 1.) The data persists
# - 2.) There are functional tests that can read/write to a test data store
# - 3.) Uses env vars to differentiate between application runtime and test runtime (i.e. to use different persistent data depending on whether it is running live or testing) 

require "./menu"
require "./user.rb"

class App
    attr_reader :environment
    def call
        # do any pre-call configuation loading, etc.
        # start application
        # ???
        # profit
        env = check_env
        load_ui(env)
    end
    

    def check_env
        environment = ENV['ENVIRONMENT']
        case environment
        when 'test'
        when 'production'
        else
            environment = 'development'
        end
        puts "running #{environment} build..."
        environment
    end

    def load_ui(environment)
        puts MENU
        loop do
            user_input = gets.chomp.downcase
            case user_input
            when "q"
                puts "Quitting..."
                break
            when "l"
                users = User.all(environment)
                if users.empty?
                    puts "There are no users yet!"
                    next
                else
                    users.each do |user|
                        puts "#{user.username}: #{user.email}"
                    end
                end
            when "a"
                puts "username: "
                username = gets.chomp
                puts "email: "
                email = gets.chomp
                user = User.new(username, email).save(environment)
                puts "Added user: #{user.username} with email: #{user.email}."
            end
        end
    end
end

app = App.new
app.call
