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