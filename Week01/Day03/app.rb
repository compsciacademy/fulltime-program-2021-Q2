# Let's talk about files :D

def read_file(file_name)
    File.open(file_name, 'r') do |file|
        file.read
    end
end

def append_to_file(file_name, file_data)
    File.open(file_name, 'a') do |file|
        file.write(file_data)
    end
end

def write_to_file(file_name, file_data)
    File.open(file_name, 'w') do |file|
        file.write(file_data)
    end
end

# lol = File.open('lol.txt')
# puts "old text:"
# puts lol.read
# lol.close
# File.open('lol.txt') do |lol|
#     puts 'old text:'
#     puts lol.read
# end
puts 'old text:'
puts read_file('lol.txt')

# hey = File.open('lol.txt', 'w')
# hey.write("Hello my friend :)\n")
# hey.close
# File.open('lol.txt', 'w') do |hey|
#     hey.write("Hello my friend :)\n")
# end
write_to_file('lol.txt', "Hello my friend! lol\n")

# what = File.open('lol.txt', 'a')
# what.write('What are you doing?')
# what.close
# File.open('lol.txt', 'a') do |what|
#     what.write("What are you doing?\n")
# end
append_to_file('lol.txt', "What do you think you are doing?\n")

# lol = File.open('lol.txt')
# puts "new text:"
# puts lol.read
# lol.close
# File.open('lol.txt') do |lol|
#     puts 'new text:'
#     puts lol.read
# end
puts 'new text:'
puts read_file('lol.txt')

write_to_file('hey.txt', "Hey there my friends!\n")
puts read_file('hey.txt')