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

A working example using `fetch()`  
```html
<!DOCTYPE html>
<meta charset="utf-8">
<title>Car List</title>

<script>
const url = 'http://localhost:4567/api/cars'

fetch(url)
  .then(lol => lol.json())
  .then(cars => {
    cars.forEach(car => {
      let pElement = document.createElement('p');
      pElement.textContent = `brand: ${car.brand}, model: ${car.model}, year: ${car.year}, color: ${car.color}`;
      document.body.appendChild(pElement);
      console.log(car);
    })
  })

</script>
```

Great! So, we've managed to figure out how to make API calls to our web API, and get JSON back, so we can use it on the client side. All we did in this case to enable CORS, was add `response.headers['Access-Control-Allow-Origin'] = '*'` to the `before do; end` block in the `/api/` namespace.  
  
## Exercise 02  
  
Let's continue to build out our client so that it can perform all actions on cars that our API supports.  
  
---

There are some somewhat useful or helpful things to keep in mind... We have worked a little with adding event listeners, and onclick attributes.   
  
```html
<!DOCTYPE html>
<meta charset="utf-8">
<title>Example</title>

<a href="#" onclick="myFunction(); return false;">click me</a><br>
<a href="javascript:void(0);" onclick="myFunction();">click me too</a><br>
<a href="#" id="myLink">Can't Click Me</a>

<script>
function myFunction() {
  alert("Hello there");
}

myLink.addEventListener('click', myFunction, false)
//myLink.setAttribute('onclick', "myFunction();");

</script>
```
