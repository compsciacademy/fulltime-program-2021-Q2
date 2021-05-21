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
      OrderItem.all.map do |order_item|
        order_item if order_item.order_number == order.order_number
      end
  end

  def self.all
    # return an array of all orders
    @order_items = [] # actually hydrate this array with OrderItems
  end
end

