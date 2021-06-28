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
