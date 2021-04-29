
class Country
    attr_reader :name, :capital
    attr_accessor :known_cities

    def initialize(name, capital)
        @name = name
        @capital = capital
        @known_cities = []
    end

    def to_s
        "#{@name}, #{@capital}, #{@known_cities}"
    end
end

def string_to_country(country_string)
    # split this up and do something useful: country_string
    a, b = country_string.split("[")
    puts a
    puts "................................"
    puts b
    puts "................................"

    Country.new("Test Country", "Test Country Capital")
end

def write_country(country)
    File.open('countries', 'a') do |file|
        file.write(country.to_s + "\n")
    end
end

def read_countries
    countries = []
    File.open('countries', 'r') do |file|
        file.each_line do |country_string|
            countries << string_to_country(country_string)
        end
    end
    return countries
end


def setup
    canada = Country.new("Canada", "Ottawa")
    canada.known_cities = ["Toronto", "Vancouver", "Victoria", "Halifax", "Montreal"]

    usa = Country.new("USA", "Washington DC")
    usa.known_cities = ["Los Angeles", "New York", "Austin", "Miami", "Seattle"]

    write_country(canada)
    write_country(usa)
end

def teardown
    system('rm countries')
end

def run_tests
    setup
    countries = read_countries
    countries.each do |country|
        puts country.name
        puts country.capital
        puts country.known_cities
    end
    teardown
end

run_tests
