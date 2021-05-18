class OrderItem
    attr_reader :name, :price, :order
    def initialize(order, name, price)
        @order, @name, @price = order, name, price
        @order.add_item(self)
    end

    def save
        File.open('order_items', 'a') do |file|
            file.write("#{@order.order_number}, #{@name}, #{@price}\n")
        end
    end

    def self.find_by_order(order)
        File.open('order_items', 'r') do |file|
            file.map do |line|
                order_number, name, price = line.split(', ')
                if order_number.to_i == order.order_number
                    OrderItem.new(order, name, price.to_i)
                end
            end
        end
    end
end
