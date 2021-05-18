require "./order_item"

class Order
    attr_reader :order_number, :sales_person, :total
    attr_accessor :items
    def initialize(sales_person)
        current_number = get_current_order_number
        @sales_person, @order_number, @items = sales_person, current_number, []
        update_order_number(current_number)
    end

    def add_item(item)
        @items << item
    end

    def total
        price = 0
        self.items.each do |item|
            price += item.price
        end
        price
    end

    def new_item(name, price)
        OrderItem.new(self, name, price)
    end

    def save
        File.open('orders', 'a') do |file|
            file.write("#{@order_number}, #{@sales_person}, #{total}\n")
        end

        @items.each do |item|
            item.save
        end
    end

    def self.last
    end

    def get_current_order_number
        # will raise an exeption if the file `.order_number`
        # does not exist
        File.open('.order_number', 'r') do |file|
            file.map do |line| 
                current_order_number = line.to_i
            end.first
        end
    end

    def update_order_number(current_number)
        File.open('.order_number', 'w') do |file|
            file.write(current_number + 1)
        end
    end
end
