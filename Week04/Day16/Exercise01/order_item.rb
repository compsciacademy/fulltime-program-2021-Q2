class OrderItem
    attr_reader :name, :price, :order
    def initialize(order, name, price)
        @order, @name, @price = order, name, price
        @order.add_item(self)
    end
end
