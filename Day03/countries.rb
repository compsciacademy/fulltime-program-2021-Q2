
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



# Look at the ruby documentation, and find a way to read a file line by line.
countries = File.open('countries')
    countries.each { |line| puts "#{countries.lineno} #{line}" }
countries.close