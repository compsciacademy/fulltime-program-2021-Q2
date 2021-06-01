class Person
  attr_accessor :name
  def initialize(name)
    @name= name
  end

  def self.greet
    "Hello"
  end
end

# puts Person.instance_methods.map { |im| "Hello!: #{im}" }

class Human < BasicObject
  attr_accessor :name

  def self.greet; "Hello"; end
end

puts Person.methods - Human.methods
