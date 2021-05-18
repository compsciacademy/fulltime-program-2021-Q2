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
end
