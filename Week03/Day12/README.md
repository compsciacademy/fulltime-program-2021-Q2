# Day 12

## Exercise 01  
  
There is a file called `app.rb` with the following:  
```ruby
names = ['Sandy', 'Corey', 'Tyler', 'Bo', 'Chris', 'Shell']

names.each { |name| Person.new(name).save }

Person.each do |person|
  puts person.to_s
end
```

Your mission, should you choose to accept it, is to write a class `Person` that can be required in the above file, that satisfies the requirement of making it work.  