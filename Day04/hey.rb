
class Country
    attr_reader :name, :capital
    attr_accessor :known_cities

    def initialize(name, capital)
        @name = name
        @capital = capital
        @known_cities = []
    end

    def to_s
        "name: #{@name}, capital: #{@capital}, known_cities: #{@known_cities}"
    end
end

canada = Country.new("Canada", "Ottawa")
canada.known_cities = ["Toronto", "Vancouver", "Victoria", "Halifax", "Montreal"]

usa = Country.new("USA", "Washington DC")
usa.known_cities = ["Los Angeles", "New York", "Austin", "Miami", "Seattle"]

def write_country(country)
    File.open('countries', 'a') do |file|
        file.write(country.to_s + "\n")
    end
end

def read_country(name)
    # find the row in the countries file with a name that matches
    # then create a country object using the data in that row and
    # return that object
    File.open('countries', 'r') do |file|
        file.each do |line|
            # row = line.split(",")
            # if row.first.match(name)
            #     country = Country.new(row.first.split[1], row[1].split[1])
            #     known_cities = row[2].split
            #     country.known_cities = row[2]
            # end
        end
    end
end

def read_countries
    # create a country object for each row in the countries file
    # and return a list of those country objects
end

# task: do something like this
# def write_country; end
# def write_countries; end

# def read_country; end
# def read_countries; end

# what should this do?
# -- this should take a Country object, and
# write it to a file, let's call it countries.
write_country(canada)
write_country(usa)

# what should this do?
# read from the file countries, and... for each line 
# (which represents a country) instantiate a country object with the data
read_country("Canada")
