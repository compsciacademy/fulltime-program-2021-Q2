require './user.rb'
require './my_test'

def setup
    name = "PassUser"
    @user = User.new(name)
    @user.email = "pass@email.com"
end

setup

def test_user_name
    description = "users should have a name"
    actual = @user.name
    expected = "PassUser"
    puts MyTest.run(description, actual, expected)
end

def test_user_email
    description = "users should have a valid email address"
    actual = @user.email
    expected = "pass@email.com"
    puts MyTest.run(description, actual, expected)
end

def test_fail_user_email
    description = "bad email address should fail"
    expected = InvalidEmailError.new("Email format is invalid").message
    actual = ''
    begin
        @user.email = "lol"
        puts MyTest.run(description, actual, expected)
    rescue InvalidEmailError => e
        actual = e.message
        puts MyTest.run(description, actual, expected)
    end
end

def run_tests
    test_user_name
    test_user_email
    test_fail_user_email
end


run_tests