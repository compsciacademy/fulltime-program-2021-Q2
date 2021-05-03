class Computer
    attr_reader :brand, :model, :year, :price_when_new, :laptop

    def initialize(brand, model, year, price_when_new, laptop=true)
        @brand = brand
        @model = model
        @year = year
        @price_when_new = price_when_new
        @laptop=laptop
    end

    def to_s
        "brand: #{@brand}, model: #{@model}, year: #{@year}, price_when_new: #{@price_when_new}, laptop: #{@laptop}"
    end

    # part b
    def used_sales_price
        age = Time.now.year - @year
        price = @price_when_new / age
        if @laptop
            price += 100
        end
        price
    end
end

mbp13 = Computer.new("Apple", 'MacBook Pro 13"', 2017, 1750)
fps13 = Computer.new("Dell", 'FPS 13"', 2017, 1250)

core2DuoMac = Computer.new("Apple", "intel Core 2 Duo", 2007, 1300)

puts mbp13.used_sales_price
puts fps13.used_sales_price
puts core2DuoMac.used_sales_price
