# Testing Active Storage with PostgreSQL

Start a new app:

```
rails new my_project -T --database=postgresql
cd my_project
bin/rails active_storage:install
bin/rails generate model User email:string

```

Make sure to add `has_one_attached :avatar` to the User model
```rb
class User < ApplicationRecord
  has_one_attached :avatar
end

```

Add a users controller

```rb
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render "user/new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :avatar)
  end
end

```

And a new and show view for users

New:
```erb
<h1>New User</h1>

<%= form_for @user do |f| %>
 <%= f.label :email %>
 <%= f.email_field :email %>
 <br>
 <%= f.file_field :avatar %>
 <br>
 <%= f.submit %>
<% end %>
```

Show:
```erb
<h1><%= @user.email %></h1>

<% if @user.avatar.attached? %>
  <%= image_tag @user.avatar %>
<% end %>
```

And make sure to add the appropriate routes.
```ruby
Rails.application.routes.draw do
  resources :users
end
```