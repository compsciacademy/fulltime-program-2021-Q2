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

---

## Review & Progress  
  
Let's start out with a new project to replace our "Car List" project, but continue with the same concepts of using a web-api and a frontend to consume it.  
  
Let's convert our `car_list.rb` to `blog.rb`. We can imagine some features in the future such as likes, upvotes/downvotes, comments, and so on, but for now, let's just focus on review of the concepts we've already covered.  
  
This means, we need to have CRUD operations for Posts. Posts will have a Post Title and a Post Body. Once we have all that functioning, we can have pagination on the Blog Post index view.  
  
**Exercise 01**  
  
Create a web API for Blogs that is able to perform all CRUD operations for Posts (use `car_list.rb`) as a reference.  
  
```ruby
require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'

Mongoid.load! 'mongoid_config.yml'

class Post
  include Mongoid::Document

  field :title
  field :body

  validates :title, :body, presence: true

  def self.page(offset_amount, limit_amount)
    all.offset(offset_amount).limit(limit_amount)
  end

  def as_json(*)
    fields = {
      id: self.id.to_s,
      title: self.title,
      body: self.body
    }
    fields[:errors] = self.errors if self.errors.any?
    fields
  end
end

get '/' do
  redirect :"/api/posts"
end

namespace '/api' do
  before do
    content_type 'application/json'
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options '*' do
    response.headers['Access-Control-Allow-Methods'] = ['PATCH', 'DELETE']
  end

  get '/posts' do
    Post.all.to_json
  end

  get '/posts/:id' do |id|
    post = Post.where(id: id).first
    unless post
      halt(404, { message: 'unable to find a post with that id' }.to_json )
    end
    post.to_json
  end

  helpers do
    def request_params
    # read the request body and attempt to parse JSON
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message: 'The JSON was unparsable' }.to_json
      end
    end
  end

  post '/posts' do
    begin
      post = Post.new(request_params)
    rescue
      halt 406, { message: 'Incorrect params!'}.to_json
    end

    if post.save
      host_address = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
      response.headers['Location'] = "#{host_address}/api/posts/#{post.id}"
      status 201
      body post.to_json
    else
      status 422
      body request_params
    end
  end

  patch '/posts/:id' do |id|
    post = Post.where(id: id).first
    unless post
      halt 404, { message: 'Cannot find a post with that id' }.to_json
    end

    if post.update(request_params)
    else
      status 422
      body request_params
    end
  end

  delete '/posts/:id' do |id|
    post = Post.where(id: id).first
    post.destroy if post 
    status 204
  end
end

```
NOTE: you probably want to add a `Gemfile`, and run `bundle install` to prepare the dependencies.   
  
With that, we have our web api server, so let's create a frontend to access it. We can start by filling in the high level function definitions: 
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>Blog</title>
  </head>
  <body>
    <h1>Heading Title</h1>
    <div id='displayArea'></div>
    <script>
      const url = 'http://localhost:4567/api/posts';

      // index does what is needed to display an index of blog posts
      function index() {}

      // show takes a post id, and does what is needed to show a single blog post
      function show(id) {}

      // show takes a post id, and does what is needed to show create inputs for a single blog post
      function create(id) {}

      // update takes a post id, does what is needed to update the post, then 'redirects' to show
      function update(id) {}

      // destroy takes a post id, does what is needed to delete the post, then 'redirects' to index
      function destroy(id) {}
    </script>
  </body>
</html>
```
  
Now, we just need to make them all work. Let's start with the index view. And let's define what we want the result to look like before we work towards building out the client-side code that creates it.  
  
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>Blog</title>
  </head>
  <body>
    <nav><a href="#">Home</a></nav>
    <h1>All Posts</h1>
    <div id='displayArea'>
      <ul>
        <li>My Blog Post Title 1 <button>View</button></li>
        <li>My Blog Post Title 2 <button>View</button></li>
        <li>My Blog Post Title 3 <button>View</button></li>
        <li>My Blog Post Title 4 <button>View</button></li>
        <li>My Blog Post Title 5 <button>View</button></li>
      </ul>
    </div>
  </body>
</html>
```

Add a `index()` or `postIndex()` function and whatever supporting functions are required.

```js
/* -----------------------
    Supporting Functions
-------------------------*/
// getPosts fetches all posts from the api and
// returns them as a list of json objects
function getPosts() {
  return fetch(url)
    .then(posts => posts.json())
}

function setHeader(text) {
  let heading = document.querySelector('h1');
  heading.textContent = text;
}

function displayNav() {
  nav = document.createElement('nav')
  homeLink = document.createElement('a');
  homeLink.textContent = 'Home';
  homeLink.setAttribute('href', '#');
  homeLink.setAttribute('onclick', "index()");
  nav.appendChild(homeLink);
  document.body.prepend(nav);
}

function clear(elements) {
  elements.forEach(element => {
    document.querySelectorAll(element).forEach(item => {
      item.parentNode.removeChild(item);
    });
  });
}

/* -----------------------
    View Logic
-------------------------*/

// index does what is needed to display an index of blog posts
function index() {
  clear(['nav', 'ul']);
  displayNav();
  setHeader('All Posts');
  let myDiv = document.querySelector('#displayArea');
  let myUl = document.createElement('ul');
  myDiv.appendChild(myUl);
  getPosts()
    .then(posts => {
      posts.forEach(post => {
        button = document.createElement('button');
        button.textContent = 'View';
        button.addEventListener('click', () => {
          show(post.id);
        }, false);
        postLi = document.createElement('li');
        postLi.textContent = post.title + ' ';
        postLi.appendChild(button);
        myUl.appendChild(postLi);
      });
    })
}

index();
```

Now that we have our index, let's move on to define a `show()` function that can be used to create the view for a blog post. Before we code the function, let's write the expected HTML output.  
  
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>Blog</title>
  </head>
  <body>
    <nav><a href="#">Home</a></nav>
    <h1>Blog Post 1 Title</h1>
    <div id='displayArea'>
      <p>This is the first paragraph of my blog post. I have no idea how we are supposed to determine when a paragraph starts and ends. You know what I mean?</p>
      <p>My body has more than one paragraph.</p>
      <p>By paragraph, do you mean sentence? "No, I don't," said the duck.</p>
    </div>
  </body>
</html>

```

As we worked through our `show()` method, we ended up adding a supporting method to call for a single post, as well as modifying the `clear()` function.  
  
```js
function getPost(id) {
  let postUrl = `${url}/${id}`;
  return fetch(postUrl)
    .then(post => post.json());
}

function clear() {
  elements = ['nav', 'ul', '#postBody'];
  elements.forEach(element => {
    document.querySelectorAll(element).forEach(item => {
      item.parentNode.removeChild(item);
    });
  });
}

function show(id) {
  clear();
  displayNav();
  getPost(id).then(post => {
    setHeader(post.title);
    postBody = document.createElement('d');
    postBody.setAttribute('id', 'postBody');
    postBody.textContent = post.body;
    displayArea.appendChild(postBody);
  });
}
```

Now we have a fork in the road. We have the functionality that supports index and show. We still need to support create, update and delete. That is, _most_ of CRUD. LOL.  
  
This just means, we can select to work on Create, Update, or Delete next.  
  
Create can start by adding a "New" link to the navigation. If clicked, it displays some input fields to add a title and body. After we submit that input, upon successful creation, it should _show_ the post.  
  
Delete should be something... maybe this is a link added to the nav on a show view. Maybe it's a button at the end of a post. Likewise for Edit. Edit, like create, displays some input fields, for title and body, but unlike create, it has the current values in them.  
  
Since both Create _and_ Update require a view for input that more or less looks the same, let's describe in HTML what that should be.
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>Blog</title>
  </head>
  <body>
    <nav><a href="#">Home</a></nav>
    <h1>New Blog Post ((OR)) Edit Blog Post Title</h1>
    <div id='displayArea'>
      <label for='title'>Title: </label><input name='title'></br>
      <label for='body'>Body: </label><br>
      <textarea name='body' rows='25' cols='150'></textarea>
    </div>
  </body>
</html>
```

We've now added a `newPost()` function that generates a view with inputs, and a `createPost()` function to create a new post, and return that create post. This allows the `newPost()` function to wait for that post, then display `show()` passing in the new post's id.  
  
```js
function createPost(post) {
  return fetch(url, {
    method: "POST",
    body: JSON.stringify(post)
  }).then(post => post.json());
}

function newPost() {
  clear();
  displayNav();
  setHeader('New Post');
  titleInput = document.createElement('input');
  titleInput.setAttribute('name', 'title');
  titleLabel = document.createElement('label')
  titleLabel.setAttribute('for', 'title');
  titleLabel.textContent = 'title: ';
  titleLabel.appendChild(titleInput);

  bodyInput = document.createElement('textarea');
  bodyInput.setAttribute('name', 'body');
  bodyInput.setAttribute('rows', '25');
  bodyInput.setAttribute('cols', '100');
  bodyLabel = document.createElement('label')
  bodyLabel.setAttribute('for', 'body');
  bodyLabel.textContent = 'body: ';
  bodyLabel.appendChild(bodyInput);

  submitButton = document.createElement('button');
  submitButton.textContent = 'create';
  submitButton.addEventListener('click', () => {
    post = {
      title: titleInput.value,
      body: bodyInput.value,
    };
    createPost(post).then(post => show(post.id));
  }, false);


  displayArea.appendChild(titleLabel);
  displayArea.appendChild(bodyLabel);
  displayArea.appendChild(submitButton);
}
```

Since we've just added the create view and supporting functions, let's go ahead and add update.  
  
As we start to add our `update()` function, we can make some changes to other functions that so we can reuse code. One such change happens in our `displayNav()` function, where we pull out `createNavLink()` logic.
```javascript
function addNavLink(addTo, link) {
  currentLink = document.createElement('a');
  currentLink.textContent = ` ${link.linkName} `;
  currentLink.setAttribute('href', '#');
  currentLink.setAttribute('onclick', link.linkFunction);
  addTo.appendChild(currentLink);
}

function displayNav() {
  nav = document.createElement('nav')
  links = [
    {
      linkName: 'Home',
      linkFunction: 'index()'
    },
    { 
      linkName: 'New',
      linkFunction: 'newPost()'
    }
  ];

  links.forEach(link => {
    addNavLink(nav, link);
  });

  document.body.prepend(nav);
}
```

Since we have pulled out `createNavLink()` we can use this function to create an "edit" link for the `show()` view that will call the `update()` function.  
  
```js
function show(id) {
  clear();
  displayNav();
  nav = document.querySelector('nav');
  
  getPost(id).then(post => {
    setHeader(post.title);
    postBody = document.createElement('d');
    postBody.setAttribute('id', 'postBody');
    postBody.textContent = post.body;
    displayArea.appendChild(postBody);

    addNavLink(nav, {
      linkName: 'Edit',
      linkFunction: `update("${id}")`
    });
  });
}
```

The next step is to complete our `update()` function:  
```js
function update(id) {
  // debugging
  console.log("Ready to edit this post: " + id);
}
```

## Homework  

Finish the update function. This should display input fields with the text values of the post that it is intended to edit. Note: You may wish to pull out some logic from `newPost()` as its own function so you can reuse the code, provided there are some obvious variables.  
