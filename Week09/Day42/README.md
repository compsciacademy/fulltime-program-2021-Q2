# Day 42  

  Continuing with CRUD operations, we had 5 main views to work on for our client-side frontend: 

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
  
And we had finished `index()`, `show()`, `create()`... so now let's finish it up!  
  
If we pull out the form building logic from `newPost()`, we might end up with something like this `formBuilder()` function:  
```javascript
function buildForm(post = null) {
  titleInput = document.createElement('input');
  titleInput.setAttribute('name', 'title');
  if(post) {
    titleInput.value = post.title;
  }
  titleLabel = document.createElement('label')
  titleLabel.setAttribute('for', 'title');
  titleLabel.textContent = 'title: ';
  titleLabel.appendChild(titleInput);

  bodyInput = document.createElement('textarea');
  bodyInput.setAttribute('name', 'body');
  bodyInput.setAttribute('rows', '25');
  bodyInput.setAttribute('cols', '100');
  if(post) {
    bodyInput.value = post.body;
  }
  bodyLabel = document.createElement('label')
  bodyLabel.setAttribute('for', 'body');
  bodyLabel.textContent = 'body: ';
  bodyLabel.appendChild(bodyInput);

  submitButton = document.createElement('button');
  submitButton.textContent = post ? 'update' : 'create';

  submitButton.addEventListener('click', () => {
    updatedPost = {
      title: titleInput.value,
      body: bodyInput.value,
    };
    if (post) {
      updatedPost.id = post.id
      updatePost(updatedPost).then(() => show(post.id));
    } else {
      createPost(updatedPost).then(post => show(post.id));
    }
  }, false);

  displayArea.appendChild(titleLabel);
  displayArea.appendChild(bodyLabel);
  displayArea.appendChild(submitButton);
}
```

Adding the destroy function is pretty straightforward from this point...  
  
---

## Exercise 01  
  
Add pagination! --- what should it look like? How should it work?

Our home page (index view) displays the title for each blog post, with a button to view it. Let's limit the view count to 5 posts, and add some pagination below it. Something like:  
  
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
      <a>1</a> <a>2</a> <a>3</a> <a>4</a> <a>5</a>
    </div>
  </body>
</html>
```
Display a link for however many pages there are. So, how can we determine many pages? Let's rephrase... if we have 25 posts, and each page has 5 posts, then how many pages should we have? What if we have 25.

```javascript
function index(offset=0) {
  clear();
  displayNav();
  setHeader('All Posts');
  let myDiv = document.querySelector('#displayArea');
  let myUl = document.createElement('ul');
  myDiv.appendChild(myUl);
  getPostsPaginated(offset, postsPerPage)
    .then(data => {
      data.posts.forEach(post => {
        button = document.createElement('button');
        button.textContent = 'View';
        button.addEventListener('click', () => {
          show(post.id);
        }, false);
        postLi = document.createElement('li');
        postLi.textContent = post.title + ' ';
        postLi.appendChild(button);
        myUl.appendChild(postLi);
      })
      generatePageLinks(data.count, myDiv);
    })
}
```
In this case, we changed the logic of our `index()` view function slightly, to call a `getPostsPaginated()` function that takes an `offset` and a `postsPerPage` argument. It will then return the number of posts defined in the `postsPerPage` parameter, and return posts starting after the `offset`.
```javascript
function getPostsPaginated(offset, limit=null) {
  let postsPaginatedUrl = `${url}?offset=${offset}`
  if(limit) { postsPaginatedUrl += `&limit=${limit}` };
  return fetch(postsPaginatedUrl)
    .then(posts => posts.json())
    .catch(e => alert(e));
}
```  
  
We also defined a `generatePageLinks()` function. It determines the `NumberOfPages`, then creates links for each, and appends them to whatever the `element` parameter is.
```javascript
function generatePageLinks(count, element) {
  let NumberOfPages;
  if(count % postsPerPage == 0) {
    numberOfPages = count / postsPerPage
  } else {
    numberOfPages = Math.ceil(count / postsPerPage)
  } 

  for (i=0; i < numberOfPages; i++) {
    link = document.createElement('a');
    link.textContent = `${i+1} `;
    link.setAttribute('href', '#');
    link.setAttribute('onclick', `index(${i * postsPerPage})`);
    link.setAttribute('class', 'pageLink');
    element.appendChild(link);
  }
} 
```

## Homework  
  
Update MyNatra:  

1. To have a presentable Readme.
2. Add options `--api-only` and `--with-api`
3. To use JavaScript to handle input data and requests.
4. To have _optional_ support for MongoDB.
  