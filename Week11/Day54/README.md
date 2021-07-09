# Day 54  
  
Today, we want to take a look at [mail](https://guides.rubyonrails.org/action_mailer_basics.html) and [file storage](https://guides.rubyonrails.org/active_storage_overview.html) with [Ruby on Rails](https://guides.rubyonrails.org/).  

## Mail with Rails  
  
When you want to do a thing, it's usually helpful if you have a thing in mind to do. It's especially helpful if you are able to articulate it.  
  
There are several reasons for this, but one is that you can use the "thing" you have in mind as a sort of anchor point or reflection point for solidifying concepts. This is better than just blindly following a tutorial or documentation, because it pushes you to apply the concept, rather than just the steps.  
  
With that in mind, _the thing_ we have in mind to do is to send mail in our Projects project to a user whose discussion has received a comment, when it receives a comment.  

---

## Step One -- Follow the Guide  
  
In our projects app, let's create a mailer for our users. Do this on a new branch, so we can easily get back to where we started if we decide to do something different later.  

```
bin/rails generate mailer user
```
  
This will create a `UserMailer` class in `app/mailers`. This acts very similarly to how controller act, and just like controllers, a mailer's methods are called actions, and have associated views.
```ruby
class UserMailer < ApplicationMailer
end

```

We can add a `welcome_email` action to the empty controller that the migration generated.

```ruby
class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @user, subject: 'Welcome to our Projects App!')
  end
end

```

And a view in `app/views/user_mailer`. Note that the name of the view is consistent with the name of the class `user_mailer` and `UserMailer`, respectively.

```html
<!DOCTYPE html>
<html>
  <head>
    <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
  </head>
  <body>
    <h1>Welcome to localhost:3000, <%= @user.first_name %></h1>
    <p>
      You have successfully signed up to My Awesome Projects!,
      your username is: <%= @user.email %>.<br>
    </p>
    <p>
      To login to the site, just follow this link: <%= @url %>.
    </p>
    <p>Thanks for joining and have a great day!</p>
  </body>
</html>
```

Also, we can add a text version of the email that Action Mailer will be able to detect and automatically generate `multipart/alternative` email ([MIME](https://en.wikipedia.org/wiki/MIME#:~:text=Most%20commonly%2C%20multipart%2Falternative%20is,use%20of%20formatting%20and%20hyperlinks.)). 

```text
Welcome to localhost:3000, <%= @user.first_name %>
===============================================

You have successfully signed up to My Awesome Projects!,
your username is: <%= @user.email %>.

To login to the site, just follow this link: <%= @url %>.

Thanks for joining and have a great day!
```

Then, if we want to call the mailer, say on user sign-up, we can add a `UserMailer` call to the create action in the users controller. However, since we are using Devise, we don't see a users controller in our app directory.

Let's try `bin/rails generate devise:controllers users` which gives us some additional setup steps:
```
===============================================================================

Some setup you must do manually if you haven't yet:

  Ensure you have overridden routes for generated controllers in your routes.rb.
  For example:

    Rails.application.routes.draw do
      devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
    end

===============================================================================
```

We also see that this has generated controllers for a variety of things that we don't care about just yet:
  * confirmations
  * omniauth_callbacks
  * passwords
  * registrations
  * sessions
  * unlocks

Knowing this, we can look at the setup example given (sessions) and infer what needs to be done just for the registrations controller.  
  
That is, we could have run `bin/rails generate devise:controllers users -c=registrations` instead, and as for setting up the routes, we will want to add:
```ruby
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
```

By default devise will not use this users controller, since the view is in the `views/devise` directory. So, copy the registrations view to a `views/users` directory.

Now, inside the `users/registrations_controller.rb` we can access the `create` action, and add some functionality within it, rather than override it.  
  
To do this, we will add a callback to super, e.g.
```ruby
# this will just use the create method from the superclass
# def create
#   super
# end

# here's how we can add functionality to it:
def create
  super do |resource|
    # in here, we'd like to add a call to the UserMailer
    UserMailer.with(user: @user).welcome_email.deliver_now
  end
end
```

If we wish to [preview mail](https://guides.rubyonrails.org/action_mailer_basics.html#previewing-emails), we add a class of the same name, followed by Preview, e.g. `UserMailerPreview` to `test/mailers/previews` with action that calls the mailer as we did above in the user controller's `create` action, without the call to `deliver_later` or `deliver_now`.

```ruby
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.with(user: @user).welcome_email
  end
end

```
We can then view the preview at [http://localhost:3000/rails/mailers/user_mailer/welcome_email](http://localhost:3000/rails/mailers/user_mailer/welcome_email).

If you are using a different location for mail previews or if you need to set the location for some reason, you can do so in the `config/application.rb`, e.g.
```ruby
  config.action_mailer.preview_path = "#{Rails.root}/tests/mailers/previews"
```

  * [simple Email configuration setup guide](https://guides.rubyonrails.org/action_mailer_basics.html#example-action-mailer-configuration)
  * [Sendgrid](https://docs.sendgrid.com/for-developers/sending-email/rubyonrails)
  * [Postmark](https://postmarkapp.com/send-email/rails)
  * [Mandrill](https://github.com/renz45/mandrill_mailer)
  * [Mailchimp](https://mailchimp.com/developer/transactional/docs/smtp-integration/)
  
## Homework

  1. Try getting mail to send using GMail, Sendgrid, or whichever SMTP server provider you'd like. Perhaps even try out a couple, time permitting.  
  
  2. Add the functionality described above, such that user A is sent an email notification when _user B_ makes a comment on a discussion that user A created.  


## Storage with Rails  
  
In our Projects project, we want to be able to add a Photo (or maybe a list of photos, ala a [carousel](https://getbootstrap.com/docs/5.0/components/carousel/)) to a project.  
  
