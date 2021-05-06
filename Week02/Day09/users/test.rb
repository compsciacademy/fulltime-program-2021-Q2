require './user'
require './my_test'


# a.) Using the above as a starting point, complete the `User` class such that it passes the following tests: 
def setup
    system('touch users')
end

def teardown
    system('rm users')
end

def run_tests
    setup
    begin

        puts "Test instantiating a new user"
        user1 = User.new('sue', 'sue@park.com')
        MyTest.expect_equal(user1.name, 'sue')
        MyTest.expect_equal(user1.email, 'sue@park.com')

        puts "Test saving a user"
        user1.save
        MyTest.expect_equal(User.last.name, user1.name)
        MyTest.expect_equal(User.last.email, user1.email)

        puts "Test find last user"
        last_user = User.all.last
        MyTest.expect_equal(User.last.name, last_user.name)
        MyTest.expect_equal(User.last.email, last_user.email)

        puts "Test find user by email"
        test_user = User.new('lolly', 'lol@lol.com').save
        MyTest.expect_equal(User.find_by_email('lol@lol.com').email, test_user.email)
        MyTest.expect_equal(User.find_by_email('lol@lol.com').name, test_user.name)
        
        test_user2 = User.new('lolface', 'lolface@lol.com').save
        MyTest.expect_equal(User.find_by_email('lolface@lol.com').email, test_user2.email)
        MyTest.expect_equal(User.find_by_email('lolface@lol.com').name, test_user2.name)
    rescue StandardError => e
        puts "Error running tests: #{e.inspect}"
    end
    
    teardown
end

run_tests
