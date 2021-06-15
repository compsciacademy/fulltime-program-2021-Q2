# Serializing an Object
# ---------------------
# reference:
# https://stackoverflow.com/questions/4464050/ruby-objects-and-json-serialization-without-rails
#
require 'json'

class User
  attr_accessor :name, :age

  def initialize(name, age)
    @name, @age = name, age
  end

  def as_json(*)
    {
      name: @name,
      age: @age
    }
  end

  def to_json(*options)
    as_json(options).to_json(options)
  end
end

user = User.new("Drew", 44)
puts user.to_json 
