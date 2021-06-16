# Day 38  
  
Let's have a look at consuming an API using an HTML front end with JavaScript. We built out an API yesterday. Let's start with the same endpoint we started with with the API, the `/cars` index, which gives a list of cars...  
  
## Exercise 01

Make a request to the API and display the result (response data) in HTML?  
  
E.G.  
```html
<!-- ... -->

<div class="displayArea"></div>

<script>
const displayArea = document.querySelector('.displayArea');

var request = new XMLHttpRequest();
request.open('GET', 'http://localhost:4567/api/cars', true)

// ...

request.send()

// ...

var res = JSON.parse(this.response);

displayArea.textContent = res;

</script>

<!-- ... -->
```
