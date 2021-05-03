class ShoppingList
    attr_reader :items

    def initialize
        @items = []
    end

    def add(*items)
        items.each do |item|
            @items << item
        end
    end
end
