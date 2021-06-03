# frozen_string_literal: true

name = "Christian"
puts name.object_id


name += "Friend"
puts name.object_id

puts "Hello #{name.upcase}!"