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
      let myDiv = document.querySelector('#myDiv');
      let pElement = document.createElement('p');
      let link = document.createElement('a');
      link.setAttribute('href', car.id)
      link.textContent = `brand: ${car.brand}, model: ${car.model}, year: ${car.year}, color: ${car.color}`;
      pElement.appendChild(link)
      myDiv.appendChild(pElement);
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

**Part I**: Using the examples above, write some code that clears the content of myDiv and appends the car object values when a link to a car is clicked.
  
Here's some code to get you started  
  
```js
// removeParagraphs removes all paragraphs that are 
// children of myDiv
function removeParagraphs() {
  paragraphs = document.querySelectorAll('p');
  paragraphs.forEach(paragraph => {
    myDiv.removeChild(paragraph);
  });
}

// updateCar takes a car object, and a url and then
// sends a patch request with the given object.
function updateCar(car, baseUrl) {
  patchUrl = `${baseUrl}/${car.id}`
  fetch(patchUrl, {
    method: 'PATCH',
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(car)
  })
}
```
