class EmailNotUniqueError < StandardError; end

class User
    attr_reader :name, :email

    def initialize(name, email)
        @name, @email = name, email
    end

    def save
        if email_unique? @email
            File.open('users', 'a') do |file|
                file.write("#{@name}, #{@email}\n")
            end
        else
            raise EmailNotUniqueError.new("Email exists!")
        end
        self
    end

    def email_unique?(email)
        email_list = []
        File.open('users', 'r') do |file|
            file.each do |line|
                email_list << line.split(', ')[1].chomp
            end
        end

        email_list.count(email) > 0 ? false : true
    end

    def self.all
        # returns a list of user objects that have 
        # been instantiated with data from the
        # data store
        users = []
        File.open('users', 'r') do |file|
            file.each_line do |user|
                name, email = user.split(', ')
                users << User.new(name, email.chomp)
            end
        end
        users
    end

    def self.last
        # returns a user object that is instantiated
        # with the data last written to the data store
        all.last
    end

    def self.find_by_email(email)
        # returns a user object based on the email
        # address
        File.open('users', 'r') do |file|
            file.each do |line|
                name, user_email = line.split(', ')
                if user_email.chomp == email
                    return User.new(name, user_email.chomp)
                end
            end
        end
    end
end
