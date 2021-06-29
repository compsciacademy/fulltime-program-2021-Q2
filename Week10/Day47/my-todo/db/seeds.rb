# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_todos(amount)
  count = Todo.count

  amount.times do |num|
    count += 1
    Todo.create({title: "My Todo # #{count}", complete: false})
  end
end

create_todos 100