# Day 53  
  
Continuing exercise review from [Day 52](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week11/Day52#day-52)  

## Exercise 02

Add [Bootstrap](https://getbootstrap.com/) to the application with appropriate classes for styling. Additionally, add a navigation menu.  
  
---  
  
We are at a bit of a fork in the road on this one. When we created our rails project, we passed in the `-J` option, which gave us an install without JavaScript, and that includes what we might use for managing [Bootstrap](https://getbootstrap.com/docs/5.0/getting-started/download/) assets, e.g. [Sprockets-Rails](https://github.com/rails/sprockets-rails) or [Webpacker](https://edgeguides.rubyonrails.org/webpacker.html).  
  
Let's try both and see which we prefer. Since we are moving into unfamiliar territory, maybe doing some exploratory coding, or simply adding a new feature to our project, these are all good reasons to create a branch off of our `main` branch, and work there. This will also allow us to have separate branches; one for the Sprockets way, and another for the Webpacker way.  
  
### Rails-Sprockets  
  
```
git checkout -b feature/bootstrap-sprockets
```

Open your gemfile and add sprockets and bootstrap

```ruby
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'bootstrap', '~> 5.0.2'
```

Run `bundle install`  
  
Change the `application.css` to `application.scss`, and import bootstrap
```
mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
```

```scss
@import "bootstrap";
```

Remove the comments that look like `*=` from the sass file.  

**Optional**  

For bootstrap JavaScript dependencies, add them to the `application.js` file, like so:
```js
//= require popper
//= require bootstrap
```

### Webpacker
  
**IMPORTANT**: From the `main` branch

```
git checkout -b feature/bootstrap-webpacker
```

Add webpacker to the rails project with `bin/rails webpacker:install`

If you have an issue that rails cannot find the task webpacker:install, then add webpacker to your gemfile:

```ruby
gem 'webpacker', '~> 5.4'
```

Then:
```
bundle install
bin/rails webpacker:install
```
  
This means that any JavaScript file in the `app/javascript/packs/` directory will get compiled into its own pack file by default. 

We'll add an `application.js` file there. This way, we can now use it in our `erb` files with the following tag: `<%= javascript_pack_tag "application" %>`. This is where we can add:

```js
import bootstrap from 'bootstrap';
```

Add Bootstrap with `yarn add boostrap`  
  
Add a `style.scss` as if it was a JavaScript file in `app/javascript/styles/styles.css`. It can be imported with `import styles/styles` and loaded in an ERB page with `<%= stylesheet_pack_tag "application" %>`

Import bootstrap in the `styles.scss`
```scss
@import 'bootstrap';
``` 

## Exercise 03  
  
Add authentication to the existing User model using [Devise](https://github.com/heartcombo/devise/wiki/How-To:-Change-an-already-existing-table-to-add-devise-required-columns). Also, make sure that a user is logged in before being able to create, modify or destroy any resources.  

Create a migration to change the users table by adding devise fields, and modifying the `email` field to work with devise.

```
bin/rails generate migration AddDeviseToUsers 
```

This gives us a fairly empty migration to change the users table. We can fill it in with the devise fields specified in the documentation

```ruby
class AddDeviseToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      ## Database authenticatable
      t.change :email, :string, :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end
  end
end

```

Add `devise_for :users` to the routes file

```ruby
Rails.application.routes.draw do
  root to: "projects#index"

  devise_for :users
  resources :projects do
    resources :discussions do
      resources :comments
    end
  end
end

```

And because currently, we can only add comments through our frontend, let's make it required to be authenticated in order to do so.

add `before_action :authtenticate_user!` to the comments controller

```ruby
class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.new(comment_params)
    if @comment.save
      redirect_to [@discussion.project, @discussion], notice: "Comment Created"
    else
      render project_discussion_path([@discussion.project, @discussion])
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end

```

We actually still haven't installed the devise gem, so let's do that now!  
  
Add `gem 'devise'` to your gemfile, run `bundle install` and then `rails generate devise:install`

You may get an error that the devise command isn't recognized, and that this usually happens when you need to specify your ORM. To resolve this, you can create a `config/initializers/devise.rb` file with the line:

```ruby
require "devise/orm/active_record"
```

Then run `rails generate devise:install`. This should prompt you with a conflict, stating that the devise.rb intilializer already exists, and asking if you'd like to overwrite it. Choose `Y` to overwrite, and things should "just work."  
  
Now, you should have some output to your terminal telling you the remaining steps:

```
===============================================================================

Depending on your application's configuration some manual setup may be 
required:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

     * Required for all applications. *

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

     * Not required for API-only Applications *

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

     * Not required for API-only Applications *

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

     * Not required *

===============================================================================
```

Since we didn't use devise generators for generating our user model, we also didn't get devise methods added to it. The devise documentation has some docs on [configuring models](https://nicedoc.io/heartcombo/devise#configuring-models).  
  
We just care about our users being able to sign in, and sign up, so we're only going to add the `:registerable`, and `:database_authenticatable` methods, for now.

```ruby
# app/models/user.rb
class User < ApplicationRecord
  validates :email, presence: true
  has_many :comments, as: :commentable
  has_many :discussions
  has_many :projects
  devise :database_authenticatable, :registerable
end

```
