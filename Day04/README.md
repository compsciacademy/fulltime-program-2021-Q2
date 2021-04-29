# Day 04

Today, we'll continue with where we left off. We have discussed some data types, data structures, Classes and Objects, CLI I/O and File I/O.

## Review

```ruby
# this should print a triangle based on the number
# passed in as count.
# e.g.
# triangle(4)
#    0
#   0 0
#  0 0 0
# 0 0 0 0

# ----

# represent a triangle in an array or rows
# where each row is a string.
# e.g. triangle(3) is:
#   0
#  0 0
# 0 0 0
# 
# In an array representation, this will look
# like this: 
# ['  0', ' 0 0', '0 0 0']
def triangle(count, symbol="0")
    rows = []
    padding = ''
    while count > 0 do
        rows[count-1] = padding
        count.times do
            rows[count-1] += "#{symbol} "
        end
        padding += ' '
        count -= 1
    end
    rows
end

puts triangle(33, '#')
```
### File Reading & Writing

We talked about how to open a file for reading or writing, using `File.open`, e.g. `File.open('<filename>', 'r')`, `File.open('<filename>', 'w')`, `File.open('<filename>', 'a')`. After opening a file into memory, it's a good idea to close it.

```ruby
# if the file does not exist, you will get 
# an error trying to read it
lol = File.open('lol.txt')
puts "old text:"
puts lol.read
lol.close

# if the file does not exist, opening it
# to write will create it.
hey = File.open('lol.txt', 'w')
hey.write("Hello my friend :)\n")
hey.close

# we can develop some methods to easily call for reading and
# writing
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

```

## Let's review Exercise 04
Create some methods for Writing and Reading country data (countries) to a file.

```ruby
class Country
    attr_accessor :known_cities

    def initialize(name, capital)
        @name = name
        @capital = capital
        @known_cities = []
    end
end

canada = Country.new("Canada", "Ottawa")
canada.known_cities = ["Toronto", "Vancouver", "Victoria", "Halifax", "Montreal"]

usa = Country.new("USA", "Washington DC")
usa.known_cities = ["Los Angeles", "New York", "Austin", "Miami", "Seattle"]

# Exercise 04 -- Solution Setup
#

def write_country(country)
    country_to_write = format_this_for_me(country)
    File.open('countries.fn', 'a') do |file|
        # file.write("#{country.to_s}\n")
        file.write(country_to_write)
    end
end
def write_countries; end

def read_country; end
def read_countries; end

```
# Exercise 01

```ruby
letters = "b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, x, z, [a, e, i, o, u, y]"

consonants, vowels = letters.split(", [")

puts consonants
puts vowels[-1] # how can we remove the last item from a string?
                # alternatively, how can we remove a character from a string, in this case "]"?
                # vowels.chomp(']')
                # vowels.replace vowels[0..-2]
                # vowels.tr("]", "")
```

Write a function that takes a word, writes it to a file as a string with its consonants each separated by a comma
and a space, and its vowels also separated by a comma and a space, but additionally wrapped in [], e.g.
`Hello => "H, l, l, [e, o]"`

Use this string to determine whether a letter is a consonant or a vowel:  
`letters = "b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, x, z, [a, e, i, o, u, y]"`

```ruby

def write(word)
    File.open('words', 'a') do |file|
        file.write(word)
    end
end

def save(word)
    word_to_write = word

    write word_to_write
end

# solution: words.rb
```

# 