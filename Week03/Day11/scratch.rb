# class Cat
#     attr_reader :name
#     def initialize(name)
#         @name = name
#     end
# end

# # TODO: Make a better algorithm
# def determine_winner(*cats)
#     cats.sample
# end

# cat1 = Cat.new("felix")
# cat2 = Cat.new("garfield")

# puts "The winner is #{determine_winner(cat1, cat2).name}!"

number = 0
loop do
    break if number > 3
    puts number
    number += 1
end