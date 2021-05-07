class Person
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def my_name
        "#{name} lol #{name}"
    end

    def my_favorite_thing
        "#{name}: soup"
    end

    def my_age 
        "#{name}: 12 years old"
    end
end

p = Person.new("lolly")

#find methods that begin with my_
#puts Person.instance_methods.grep(/my_/)


# now that we've found all the methods that begin with my_,
# how would I go about running them on p (an instance of person)?
Person.instance_methods.grep(/my_/).each do |lol|
    puts p.send(lol)
end

# now that we have a way to send method calls to an object
# based on their formatting, wouldn't it be great (convenient)
# if we could wrap sets of function calls in a descriptive
# block, so we can quickly and easily see the intent.
def describe(description)
    puts description
    yield
end

describe "Test Person Object Behavior" do
    Person.instance_methods.grep(/my_/).each do |lol|
        puts p.send(lol)
    end
end