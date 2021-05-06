# Day 09

When we write tests, typically we want to evaluate that a given input or set of inputs results in an expected output or set of outputs. With that in mind, testing can be somewhat easy (it isn't always easy in practice, but the idea of evaluating actual and expected can be).  
  
```ruby
def add(a, b)
  a + b
end

# I know that if I input 2 and 2, I expect 4 to be returned
# likewise, I can expect to have 3 returned if I input 1 and 2.
# This makes creating a test fairly easy

expected = 4
actual = add(2, 2)
if actual == expected
    puts "PASS"
else
    puts "FAIL"
end

# With that sort of logic in mind, we could put it in a function
# or sets of functions (if we have some other logic to add) and
# now have somewhat of our own testing framework.
# i.e.
module MyTest
    def expect_equal(actual, expected)
        if actual == expected
            puts "PASS"
        else
            puts "FAIL"
        end
    end
end
# now if we want to test something, we can just call our test
# framework

def multiply(a, b)
    a * b
end

MyTest.expect_equal(multiply(3, 5), 15)
MyTest.expect_equal(multiply(2, 7), 14)
MyTest.expect_equal(multiply(6, 8), 48)
MyTest.expect_equal(multiply(3, 500), 1500)

# We can use this framework to test other functionality as well, 
# let's see how we might test a User class
class User
    attr_reader :name, :email

    def initialize(name, email)
        @name, @email = name, email
    end

    def save
        # saves user object data to some sort of data
        # store that can be used to read from to 
        # instantiate instances of user objects
    end

    def self.all
        # returns a list of user objects that have 
        # been instantiated with data from the
        # data store
    end

    def self.last
        # returns a user object that is instantiated
        # with the data last written to the data store
    end

    def self.find_user_by_email(email)
        # returns a user object based on the email
        # address
    end
end

# create a new user
user1 = User.new('sue', 'sue@park.com')

# test that the user object instantiated has the
# correct values
MyTest.expect_equals(user1.name, 'sue')
MyTest.expect_equals(user1.email, 'sue@park.com')

# test that the last saved user data matches the
# user that we saved last
user1.save # saves the user data
MyTest.expect_equals(user1.name, User.last.name)
MyTest.expect_equals(user1.email, User.last.email)

```

**Exercise 01**  
  
a.) Using the above as a starting point, complete the `User` class such that it passes the following tests: 

```ruby
user1 = User.new('sue', 'sue@park.com')
MyTest.expect_equals(user1.name, 'sue')
MyTest.expect_equals(user1.email, 'sue@park.com')

user1.save
MyTest.expect_equals(user1.name, User.last.name)
MyTest.expect_equals(user1.email, User.last.email)
```
