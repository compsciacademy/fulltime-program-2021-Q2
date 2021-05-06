require './user'
require './my_test'


# a.) Using the above as a starting point, complete the `User` class such that it passes the following tests: 
def run_tests
    user1 = User.new('sue', 'sue@park.com')
    MyTest.expect_equal(user1.name, 'sue')
    MyTest.expect_equal(user1.email, 'sue@park.com')

    user1.save
    MyTest.expect_equal(User.last.name, user1.name)
    MyTest.expect_equal(User.last.email, user1.email)

    last_user = User.all.last
    MyTest.expect_equal(User.last.name, last_user.name)
    MyTest.expect_equal(User.last.email, last_user.email)
end

run_tests
