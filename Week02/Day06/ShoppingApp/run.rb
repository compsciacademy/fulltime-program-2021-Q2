require_relative './cli/cli'
require_relative './shopping_list'

def run
    puts "My Shopping List Application is running ..."
    load_cli
    list = ShoppingList.new
    list.add "corn"
    list.add "milk"
    list.add 'eggs', 'bread', 'cheese', 'tomatoes'

    puts list.items
end

run
