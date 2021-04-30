require './data/datastore'

class User
    attr_accessor :name, :email_address

    def initialize(name='', email_address='')
        @name, @email_address = name, email_address
    end

    def save
        "Saving: #{self.inspect}..."
        [self.name, self.email_address].each do |item|
            unless unique(item)
                raise "#{item} not unique!"
            end
        end
        
        self.write
    end

    def self.all
        users = []
        Datastore.list('users').each do |user_string|
            name, email = user_string.split(', ')
            users << self.new(name, email)
        end
        users
    end

    def to_s
        "#{self.name} #{self.email_address}"
    end

    private

    # TODO: make this function actually do something
    def unique(item)
        # check to see if name or email is unique
        puts "I don't care if #{item} is unique, and neither should you!"
        true
    end

    def write
        Datastore.write(self.class, self.to_s)
    end
end

def create_user(name, email_address)
    user = User.new
    user.name = name
    user.email_address = email_address
    
    user.save
end