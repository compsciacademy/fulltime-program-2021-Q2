# Day 46  
  
**Note**: While reviewing documentation, we frequently come across areas of interest. Here are some from today:  
  
  * [ActionMailer](https://guides.rubyonrails.org/action_mailer_basics.html)
  * [ActionCable](https://guides.rubyonrails.org/action_cable_overview.html)
  * [ActiveStorage](https://guides.rubyonrails.org/active_storage_overview.html)
  
Have a look at rails documentation. Feel free to Google as well, but there's an amazing resource available at your fingertips that will allow you to answer this question:  
  
What is the difference between `resource` and `scaffold` in the context of `rails generate`, e.g.

What is the difference between:  
```
bin/rails generate resource post title:string body:text
```
and
```
bin/rails generate scaffold post title:string body:text
```

A couple of ways to answer this are:   
  
1. Read the help menu  
  
```
bin/rails generate resource --help
bin/rails generate scaffold --help
```

2. Try them out and see what they do  
  
---

After playing around with them, it was pretty easy to find out precisely what the differences were. The help menu for generating a resource gives a good description that includes:  
  
_"Unlike the scaffold generator, the resource generator does not create views or add any methods to the generated controller."_  
  
## Exercise 01  
  
Create a new rails project with blog posts and users. Posts belong to users. Let's use [Devise](https://github.com/heartcombo/devise) for our user authentication.  
  
Add `gem 'devise'` to the Gemfile, then run `bundle install`, and `bin/rails generate devise:install`. This will show some instructions in the console:  
  
```md
===============================================================================

Depending on your application's configuration some manual setup may be required:

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

Now, let's generate our `User` model using devise.  
  
```
bin/rails generate devise User
```  
  
and `bin/rails db:migrate`  
  
We added the following to our `posts_controller.rb` and bam! We have user authentication for everything except the index and show views: 

```rb
before_action :authenticate_user!, except: [:index, :show]
```  
  
---

Next up, let's have a look at User Authentication with the [AuthLogic](https://github.com/binarylogic/authlogic) gem.  
  
  
Add `gem 'authlogic'` to your gemfile, `bin/bundle install`, and create a user model.  
  
e.g. 
```
bin/rails generate migration CreateUser email:string:uniq login:string crypted_password:string crypted_salt:string persistence_token:string:uniq:index single_access_token:uniq:index perishable_token:uniq:index login_count:integer failed_login_count:integer last_request_at:datetime current_login_at:datetime last_login_at:datetime current_login_ip last_login_ip active:boolean approved:boolean confirmed:boolean
```

update the default values...

```rb
class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :login
      t.string :crypted_password
      t.string :crypted_salt
      t.string :persistence_token
      t.string :single_access_token
      t.string :perishable_token
      t.integer :login_count, default: 0, null: false
      t.integer :failed_login_count, default: 0, null: false
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
      t.boolean :active, default: false
      t.boolean :approved, default: false
      t.boolean :confirmed, default: false

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :persistence_token, unique: true
    add_index :users, :single_access_token, unique: true
    add_index :users, :perishable_token, unique: true
  end
end
```

And add some validations to the User model  

```rb
class User < ApplicationRecord
  acts_as_authentic

  validates :email, uniqueness: true, length: { maximum: 100 }
  validates :login, uniqueness: true
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, length: { minimum: 8 }
end
```

And define a UserSession model for Authlogic: 

```rb
class UserSession < AuthLogic::Session::Base
end
```

And a UserSessions controller:  
```rb
class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params.to_h)
    if @user_session.save
      redirect_to root_url
    else
      render action: :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_url
  end

  private

  def user_session_params
    params.require(:user_session).permit(:login, :password, :remember_me)
  end
end

```

Add some helper methods to the ApplicationController  
  
```rb
class ApplicationController < ActionController::Base
  helper_methods :current_user_session, :current_user

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    if defined?(@current_user)
      return @current_user
    end
    @current_user = current_user_session && curent_user_session.user
  end
end

```

And add resources to routes: 

```ruby

  resources :users
  resource :routes
```

And a view
```js
<%= form_for @user_session, url: user_session_url do |f| %>
  <% if @user_session.errors.any? %>
  <div id="error_explanation">
    <h2><%= pluralize(@user_session.errors.count, "error") %> prohibited:</h2>
    <ul>
      <% @user_session.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
    </ul>
  </div>
  <% end %>
  <%= f.label :login %><br />
  <%= f.text_field :login %><br />
  <br />
  <%= f.label :password %><br />
  <%= f.password_field :password %><br />
  <br />
  <%= f.label :remember_me %><br />
  <%= f.check_box :remember_me %><br />
  <br />
  <%= f.submit "Login" %>
<% end %>
```