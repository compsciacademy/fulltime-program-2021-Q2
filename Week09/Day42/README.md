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