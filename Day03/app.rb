class Country
    attr_reader :country
    attr_accessor :cities

    def initialize(country, cities=[])
        @country = country
        @cities = cities
    end

    # setter
    def capital=(capital)
        @capital = capital
    end

    # def cities=(cities)
    #     @cities = cities
    # end
end

class City
    attr_accessor :population
    attr_reader :name

    def initialize(name)
        @name = name
    end
end

class Province; end
class State; end
class Prefecture; end
class Other; end
city = City.new("Vancouver")
cities = []
cities << city

puts cities

puts "..........."

puts [City.new("Vancouver")]

# c = Country.new("Canada", cities)
# c = Country.new("Canada", [City.new("Vancouver")])



# ottawa = City.new("Ottawa")
# ottawa.population = 1,500,000
# c.capital = ottawa
# c.cities << ottawa