require './user.rb'

# I should be able to instantiate a user.
def instantiate_user(name, email_address)
    begin
        u = User.new(name, email_address)
    rescue NameError => e
        puts "FAIL: #{e.message}"
    else
        puts "PASSED: instantiate_user"
        u
    end
end

# users have a name and an email address
def has_name(user)
    begin
        raise NameError.new("`name` should not be nil") if user.name.nil?
    rescue NameError => e
        puts "FAIL: #{e.message}"
    else
        puts "PASSED: has_name(user)"
    end
end

def has_email_address(user)
    begin
        raise NameError.new("`email_address` should not be nil") if user.email_address.nil?
    rescue NameError => e
        puts "FAIL: #{e.message}"
    else
        puts "PASSED: has_email_address(user)"
    end
end

def email_address_format(email_address)
    # ensure that email addresses match the pattern:
    # `<string>@<string>.<string>`

end

def run_tests
    begin
        user = instantiate_user("TestUser", "testemail")
    rescue StandardError => e
        puts "FAIL: #{e.message}"
    end

    has_name(user)
    has_email_address(user)
    email_address_format(user.email_address)
end

run_tests