require './user.rb'

# I should be able to instantiate a user.
def instantiate_user(name, email_address)
    begin
        u = User.new(name, email_address)
    rescue NameError => e
        puts "FAIL: #{e.message}"
    else
        puts "PASS: instantiate_user"
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
        puts "PASS: has_name(user)"
    end
end

def has_email_address(user)
    begin
        raise NameError.new("`email_address` should not be nil") if user.email_address.nil?
    rescue NameError => e
        puts "FAIL: #{e.message}"
    else
        puts "PASS: has_email_address(user)"
    end
end

def email_address_format(email_address)
    # ensure that email addresses match the pattern:
    # `<string>@<string>.<string>`
    if email_address.count('@') != 1
        puts "FAIL: email address must contain exactly one @"
        return
    end

    email_address_array = email_address.split('@')
    if email_address_array.length != 2
        puts "FAIL: email address must have a domain"
        return
    elsif email_address_array[1].count('.') == 0
        puts "FAIL: email address domain must contain a '.'"
        return
    else
        puts "PASS: email_address_format(email_address)"
    end

    # if email_address_array[1]

    # begin
    #     unless email_address.split('@')[1].count('.') >= 1
    #         puts "FAIL: email address not formatted correctly"
    #     end
    # rescue StandardError => e
    #     puts "FAIL: #{e.message}"
    # else
    #     puts "PASS: email_address_format(user)"
    # end
end

def run_tests
    begin
        user = instantiate_user("TestUser", "testemail@dot.com")
    rescue StandardError => e
        puts "FAIL: #{e.message}"
    end

    has_name(user)
    has_email_address(user)
    email_address_format(user.email_address)
end

run_tests

# test that user = User.new(name, email); user.greet => "Hello. My name is <name>!"
# username = "Dan"
# actual = user.greet
# expected = "Hello. My name is #{username}!"

# if actual != expected
#     # fail
# else
#     # pass
# end
