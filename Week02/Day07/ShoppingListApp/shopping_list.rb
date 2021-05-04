require_relative './datastore'

class ShoppingList
    attr_writer :items

    def initialize(items=[])
        @items = items
    end

    def save
        DataStore.open(@items.join(', '), 'w')
    end

    def self.read
        DataStore.open('').split(', ')
    end

    def self.delete
        DataStore.open('', 'w')
    end
end
