# Day 12

## Exercise 01  
  
There is a file called [`main.rb`](https://replit.com/@DrewOgryzek/LolPerson) with the following:  
```ruby
require './person'

names = ['Sandy', 'Corey', 'Tyler', 'Bo', 'Chris', 'Shell']

names.each { |name| Person.new(name).save }

Person.all.each do |person|
  person.greeting = ["I like milk.", "Potato is my name friend", "Don't worry about candy face.", "Some salad is vegan.", "Do it or do not, but don't wait!", "What is the way to the place?", "Who said, 'Hey there! Hi... and then something?'"].sample
  person.save
end

Person.all.each do |person|
  person.greet do |name, greeting|
    puts "Harry: Hi! I am Harry. How are you? What's your name?"
    puts "#{name}: #{greeting}"
  end
end
```

Your mission, should you choose to accept it, is to write a class `Person` that can be required in the above file, that satisfies the requirement of making it work.  

```ruby
# person.rb

class Person
  attr_reader :name
  attr_accessor :greeting
  @@people = {}

  def initialize(name)
    @name = name
  end

  def save
    @@people[self.name] = self
  end

  def greet
    yield(@name, self.to_s)
  end

  def self.all
    people_objects = []
    @@people.each do |k, v|
      people_objects << v
    end
    people_objects
  end

  def to_s
    "My name is #{@name}! #{@greeting}"
  end
end
```

## Exercise 02  
  
This time, let's build out a Pacman-like game. First, let's think through some of the objects we might have, how they might interact, and what other things may be necessary.  
  
Pacman eats balls. There are two types of balls, regular balls which just count as single unit points. All regular balls on a board must be consumed for the board to be cleared.  

There are super balls, or balls that when consumed cause Pacman to be able to consume ghosts for a limited amount of time. Consuming ghosts gives Pacman points. The ghosts respawn after they are consumed.
  
There are up to N number of ghosts (how many?) on a board. Ghosts come in a variety of colors. Do the colors have any special attributes or properties? Do ghosts have any abilities other than to move around on the board?  
  
Thinking through this, it's pretty obvious that balls, ghosts, and pacman could be objects. There may also be some other objects (or at least classes) to be instantiated for a game, but let's start here.  
  
**Part a.)**  

Define the properties, attributes, methods, etc. for Ball and Ghost classes. Then write a program that instantiates at least 2 of each.  
  
```ruby
class Ball; end
class Ghost; end
```

## Exercise 03

Let's switch our focus a little now to developing a useful application for our office! That's right, it's time for the Employee App! Hurray!!!  
  
How is our employee application going to work? Here are a couple of requirements, but it isn't an exhaustive list.
  
The administrator should be able to save an employee. Employees have a name, employee id, email address, salary, start date, starting salary, vacation days and maybe some more stuff that we don't remember offhand, but will surely let you know is missing, as soon as we use the system.  
  
The administrator should be able to find employees (or search for employees) by their attributes, e.g. "find all employees with a yearly salary greater than $100,000," or "find employee with the email address hello@friends.com."  
  
Employees should be able to view their own records and update their email addresses.  
  
Only the administrator should be able to view (and edit) all records, as well as create or delete records.  
  
**Features**:
 * Add employee to system  
 * View employees  
 * Find an employee  
 * Edit employee  
 * Delete employee  
 * Permissioned access: Admin vs employee (employee can only view self/edit email)

```ruby
employees = {
    "christian" =>  "christian@arab.com", 
    "drew" => "drew@ogryzek.com",
    "welder jo" => "welder.jo@welding.com"
}

def load(employees)
    employees.each do |name, email|
        Employee.new(name, email).save
    end
end

load(employees)
```

Example of some ideas for Admin vs Employee:

```ruby
class Employee
  attr_reader :is_admin

  def initialize(name, email, is_admin='false')
    @is_admin = is_admin
  end

  def is_admin?
    @is_admin
  end
end
```

Then, you can check if `@employee` (`current_user`, etc.) `is_admin?`, and offer some functionality to them:

e.g. 
```ruby
admin_menu = <<-ADMIN_MENU

ADMIN MENU
----------

u  update employee
d  delete employee
a  add employee

ADMIN_MENU

if @employee.is_admin?
    puts admin_menu
end
```

Or perhaps instead of calling the logged in user `@employee`, it could be something like `@current_user`. Whatever you like...  
  
Another thing you may think of is how to store passwords. You might not wish to store them using plain text, so what can you do? One way, which may have some issues, but will work for us, for now can be to encrypt the passwords.  
  
```ruby
def encrypt(some_string)
    # this algorithm is going to replace
    # consonants with * and vowels with _
    # with the following exceptions:
    # q,r,s,t are replaced by &&, a, f z
    # are replaced by ^.
    #
    # Specials characters and numbers are
    # unsupported.
    #
    # e.g.
    #   encrypt("pizza")
    #   => "*_^^^"
end

```

