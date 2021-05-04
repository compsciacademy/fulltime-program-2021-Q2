class ShoppingList
    attr_writer :items

    def initialize(items=[])
        @items = items
    end

    def save
        filename = 'shopping_list'
        method = 'w'
        data = @items
        File.open(filename, method) do |file|
            file.write(data.join(', '))
        end
    end

    def self.read
        filename = 'shopping_list'
        method = 'r'
        item = ''
        File.open(filename, method) do |file|
            item += file.read
        end
        item.split(', ')
    end

    def self.delete
        filename = 'shopping_list'
        method = 'w'
        data = ''
        File.open(filename, method) do |file|
            file.write(data)
        end
    end
end