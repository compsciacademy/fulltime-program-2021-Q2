class User
    attr_reader :name, :email

    def initialize(name, email)
        @name, @email = name, email
    end

    def save
        # saves user object data to some sort of data
        # store that can be used to read from to 
        # instantiate instances of user objects
        File.open('users', 'a') do |file|
            file.write("#{@name}, #{@email}\n")
        end
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
    end
end
