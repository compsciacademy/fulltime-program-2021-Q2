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
  
This means that any JavaScript file in the `app/javascript/packs/` directory will get compiled into its own pack file by default. 

We'll add an `application.js` file there. This way, we can now use it in our `erb` files with the following tag: `<%= javascript_pack_tag "application" %>`. This is where we can add:

```js
import bootstrap from 'bootstrap';
```

Add Bootstrap with `yarn add boostrap`  
  
Add a `style.scss` as if it was a JavaScript file in `app/javascript/styles/styles.css`. It can be imported with `import styles/styles` and loaded in an ERB page with `<%= stylesheet_pack_tag "application" %>`

## Exercise 03  
  
Add authentication to the existing User model using [Devise](https://github.com/heartcombo/devise/wiki/How-To:-Change-an-already-existing-table-to-add-devise-required-columns). Also, make sure that a user is logged in before being able to create, modify or destroy any resources.  
  