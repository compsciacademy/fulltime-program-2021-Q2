# Day 41  
  
Filtering the data can be done by chaining methods. The [Mongoid documentation](https://mongoid.github.io/old/en/origin/docs/selection.html) is pretty good. We can see that there are some differences with [ActiveRecord Querying](https://guides.rubyonrails.org/active_record_querying.html).  
  
The way that chaining methods works is that the methods combine to create a query string, and then the data is queried, so you're not hitting the database with calls on each method.  
  
In order to query through IRB, you'll need to load the Mongoid model.  
  
E.g. `load "./car_list.rb"`  
  
Here are some example queries:
```ruby
# Select all cars, and order by brand, ascending (alphabetically from a - z):
Car.order([:brand, :asc])

# Use the custom page scope to select 6 cars starting from the 7th car:
Car.order([:brand, :asc]).page(6, 6)

# Select all cars made between 1960 and 1975, ordered by model, descending (reverse alphabetical order)
Car.order([:model, :desc]).where({year: {'$gt': 1959}}).where(year: {'$lte': 1976})
```

Now, we would like to prove some things out. For example, we used `:asc` and `:desc` to see which direction they sort. To prove that to ourselves, we just look at the returned data.  
  
We can do the same sort of proving out of other things also by constructing queries, querying the data, and observing the result sets.  
  
1.) We have a custom scope called page, which has been defined by us, like this:
```ruby
  def self.page(offset_amount, limit_amount=6)
    all.offset(offset_amount).limit(limit_amount)
  end
```

What we want to prove is whether the offset amount, say 6, is inclusive or exclusive of the 6th record (i.e. is the 6th record included in the results or not?).

```ruby
# Using this in our command line should make it pretty obvious
Car.all.each { |car| puts car.to_json }
Car.page(0,3).each { |car| puts car.to_json }
Car.page(3,3).each { |car| puts car.to_json }
```
  
2.) Are `'$gt'` and `'$lte'` inclusive or exclusive?  

Interestingly, through our testing, we discovered that `'$gt'` is exclusing, but adding an `e` to it (`'$gte'`) makes it _inclusive_. Likewise, `'$lte'` is inclusive, but removing the `e` from it (`'$lt'`) makes it exclusive.  
  
```ruby

# includes cars from years 1968 and 1970
Car.where(year: {'$gte': 1968}).where(year: {'$lte': 1970}).each { |car| puts car.inspect }

# Does not include cars from years 1968 and 1970
Car.where(year: {'$gt': 1968}).where(year: {'$lt': 1970}).each { |car| puts car.inspect }
```
