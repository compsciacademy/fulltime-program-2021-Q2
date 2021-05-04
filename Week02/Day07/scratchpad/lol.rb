# Let's work with some read/write functions directly on a file
# so we can see quickly, easily and in isolation what is going on.
#


def read
    item = ''
    File.open('my_list', 'r') do |file|
        item += file.read
    end
    return item.split(', ')
end


def write(item_list)
    File.open('my_list', 'w') do |file|
        file.write(item_list.join(', '))
    end
end

list = ['a', 'b', 'c', 'd']

write(list)
my_list = read

puts "#{my_list.class}: #{my_list}"