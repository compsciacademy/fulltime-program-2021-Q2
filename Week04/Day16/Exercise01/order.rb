class Order
    attr_reader :order_number
    attr_accessor :items
    def initialize
        current_number = get_current_order_number
        @order_number, @items = current_number, []
        update_order_number(current_number)
    end

    def add_item(item)
        @items << item
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
