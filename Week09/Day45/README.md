# Day 45  

To add or remove fields (or attributes) from records in the database, we can generate a migration. Try to give migrations a meaningful name that represent what they are doing.  
  
```
bin/rails generate migration AddStatusToArticles status:string
```

This will give us a migration, following the pattern `AddFieldToModel`, it will have assumed that we want to add a column called status to the Articles table.  
  
```ruby
class AddStatusToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :status, :string
  end
end

```

We may wish to add a default value, like public. To do so, we can just add `default: 'public'`
```ruby
class AddStatusToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :status, :string, default: 'public'
  end
end
```

If we want the `status` column to exist for comments, we also have to create that!

```
bin/rails generate migration AddStatusToComments status:string
```

After running `bin/rails db:migrate` our comments will have `nil` statuses, because unlike Articles, we didn't set a default.  
  
There are a couple of ways we could go about doing something for this.  
  
One is to open up `bin/rails console` and update the status of each comment that has a `nil` status.  
  
```ruby
Comment.where(status: nil).each do |comment|
  comment.update(status: 'public')
end
```

Another way we could do this is to create a [custom task](https://guides.rubyonrails.org/command_line.html#custom-rake-tasks). 
  
Create a `.rake` file in `lib/tasks`. In this case, we'll use the `:db` namespace, give it a description and a task name, and do basically the exact same thing we could have done through the console (as shown above).  
  
```rake
namespace :db do
  desc "Updates nil comment status to 'public'"
  task :update_comment_status => :environment do
    Comment.where(status: nil).each do |comment|
      comment.update(status: 'public')
    end
  end
end
```

Now that we have a `status` field for comments and articles, we should add it as an accepted param.  
  
```ruby
# articles_controller.rb

# ...

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

```

```ruby
# comments_controller.rb

  def comments_params
    params.require(:comment).permit(:commenter, :body, :status)
  end

```

And then add a way to actually set this param in the views  
  
```html
  <p>
    <%= form.label :status %><br>
    <%= form.select :status, ['public', 'private', 'archived'] %>
  </p>
```

## Exercise 01

Knowing that Rails uses the `db/seeds.rb` file when you run `bin/rails db:seed`, let's make use of it and fill in our database with a bunch of articles and comments.  
  
```rb
# seeds.rb

# create 100 blog articles, with 10 to 100 comments each.

#Let's break down the task into chunks. Step 1: Create a blog article. 
 
def rand_word(length=(5..10))
  ('a'..'z').to_a.sample(rand(length)).join
end

def rand_title
  title = ''
  rand(3..5).times do
    title += rand_word(5..15).capitalize + ' '
  end
  title
end

def rand_sentence
  sentence = rand_word.capitalize
  rand(3..15).times do
    sentence += rand_word + ' '
  end
  sentence.rstrip!
  sentence += "."
end

def rand_body
  body = ''
  rand(15..36).times do
    body += rand_sentence + ' '
  end
  body
end

def rand_status
  ['public', 'private', 'archived'].sample
end

def rand_article
  Article.create(title: rand_title, body: rand_body, status: rand_status)
end

def rand_comment(article)
  article.comments.create(commenter: rand_word.capitalize, body: rand_body, status: rand_status)
end

def create_articles_with_comments(amount)
  amount.times do
    article = rand_article
    puts article.id
    rand(10..100).times do
      rand_comment(article)
    end
  end
end

create_articles_with_comments 100

```

If you noticed the pattern of initializing a variable as an empty string, then concating a string with it, and then returning it at the end, you may also notice that wew could use `.map` to clean this up somewhat...  
  
e.g. 
```ruby
def rand_title
  title = ''
  rand(3..5).times do
    title += rand_word(5..15).capitalize + ' '
  end
  title
end

# could be rewritten to:
def rand_title
  rand(3..5).times.map do
    rand_word(5..15).capitalize + ' '
  end.join(' ')
end

# we can take this a step further
def rand_title
  Array.new(rand(3..5)) do
    rand_word(5..15).capitalize + ' '
  end.join(' ').rstrip!
end
```

You might be wondering which way is better, why, and how you might find out for yourself.  
  
One way that might come to mind is to find a way to make a measurement and determine based on the best numbers. What sort of measurement might we make with code?  
  
Lines of code, for the most part, is _not_ a very reasonable way to measure code quality. So what is a reasonable way to measure code? Perhaps _quality_ wasn't the best qualifier. How about we measure _speed_ or _resources_ required?  
  
Ruby has a great library that we can just _use_. It's called [Benchmark](https://ruby-doc.org/stdlib-2.5.0/libdoc/benchmark/rdoc/Benchmark.html). To use it, simply `require 'benchmark`  
  
```ruby
require 'benchmark'

Benchmark.bm do |x|
  # now we can do something and get a benchmark.
  # in order to read the results of the benchmark, we
  # can use x.report { and put code in here }

end
  
```

## Exercise 02

Look at the various ways to write our functions using string variables vs `.map` vs `Array.new`, and come up with some benchmarks to see which way is the best for our use case.  
  
We will want to remove the randomness, so we can focus on the techniques for writing the functions, not on whether they happen to be doing more work or not.

```ruby 
# benchmarks.rb
require 'benchmark'
def rand_word(num=3)
  ('a'..'z').to_a.sample(num).join
end

def rand_title_one
  title = ''
  5.times do
    title += rand_word.capitalize + ' '
  end
  title.rstrip!
end

# could be rewritten to:
def rand_title_two
  5.times.map do
    rand_word(8).capitalize + ' '
  end.join(' ').rstrip!
end

# we can take this a step further
def rand_title_three
  Array.new(4) do
    rand_word(5).capitalize + ' '
  end.join(' ').rstrip!
end

n = 10000

Benchmark.bm(10) do |x|
  x.report("one: ") { n.times { rand_title_one }}
  x.report("two: ") { n.times { rand_title_two }}
  x.report("three: ") { n.times {rand_title_three }}
end

```
