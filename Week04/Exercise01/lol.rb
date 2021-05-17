# Inventory system for Materials, Orders, Inventory, Warehousing/storage
#  --------------------------------------------------------------------
# We need to be able to add, modify, potentially clone materials
# and orders, that is CRUD operations of course... but also
# the idea of cloning. We can explore this as our app takes shape.
# 

class App
    def run
        loop do
            load_ui
        end
    end
end

App.new.run

# Is there a difference between a material and an order item?
{
    "name": "iron-bar",
    "sku": "1005E111-iron",
    "properties": {"key": "value"},
    "cost": "",
    "supplier": "",
}

# Question: What is a Material? Indeed, wouldn't it be nice if we hade some use-cases
# for how our system should work?
#
#
#