# Day 40  
  
Something about day 40  
  
## Cars List Review
  
Let's review our Cars List project that uses a JavaScript powered frontend to perform CRUD operations through our Ruby API.  
  
Maybe today, before we look at code, we can think through what we want our UI to look like. So, before we do that, let's decide what _views_ we want to have to perform these CRUD operations.  
  
 * [Index](#Index)  
 * [New](#New)  
 * [Show](#Show)  
 * [Edit](#Edit)    
   
### Index

Our Index should show a list of all the cars, with the ability to select a single car to show, edit, or delete.  
  
Selecting delete from Index should remove that car from the index view and from the API data store.  
  
Selecting to show a car from the index can be the same thing as selecting to edit a car from the index. In this case. However, we could just have view for show, and then another view with a form (input fields) for edit.  
  
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Car List</title>  
  </head>
  <body>
    <h1>Cars</h1>

    <div id="displayArea">
      <p>Brand: Ford, Model: Mustang, Color: Black, Year: 1968 <button>Show/Edit</button></p>
      <p>Brand: Ford, Model: Mustang, Color: Black, Year: 1969 <button>Show/Edit</button></p>
      <p>Brand: Ford, Model: Mustang, Color: Black, Year: 1970 <button>Show/Edit</button></p>
      <p>Brand: Ford, Model: Mustang, Color: Black, Year: 1971 <button>Show/Edit</button></p>
      <p>Brand: Ford, Model: Mustang, Color: Black, Year: 1972 <button>Show/Edit</button></p>
      <p>Brand: Ford, Model: Mustang, Color: Black, Year: 1973 <button>Show/Edit</button></p>
      <p>Brand: Ford, Model: Mustang, Color: Black, Year: 1974 <button>Show/Edit</button></p>
      <hr>
    </div>
  </body>
</html>
```

### New  

New should give form fields for entering whatever information is required by the API to create a new car.  
  
Submitting the form, or clicking "create" should send a POST request to the API to create the car (i.e. add it to the backing store).  
  
From there we could move to the _show_ view for that car, or we could move to the _index_ view of all cars, or anything we'd like to do. In this case, let's have it show the car's show view.  
 
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Car List</title>  
  </head>
  <body>
    <h1>New Car</h1>

    <div id="displayArea">
      <label for="brand">Brand: </label><input id="brand"><br>
      <label for="model">Model: </label><input id="model"><br>
      <label for="color">Color: </label><input id="color"><br>
      <label for="year">Year: </label><input id="year"><br>
      <button>Create</button>
      <hr>
    </div>
  </body>
</html>
```

### Show  
  
As mentioned above, we could have this show view be a nice display for a single car. Perhaps if we had photos, descriptions, reviews, or any other information for cars, this would be where we could expand upon it, and give a nice view.  
  
However, in our case, we don't particularly have any special information to share or display, so let's just combine this with our edit view.

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Car List</title>  
  </head>
  <body>
    <h1>1973 Mustang</h1>

    <div id="displayArea">
      <p>Brand: Ford, Model: Mustang, Color: Black, Year: 1973 <button>Show/Edit</button></p>
      <label for="brand">Brand: </label><input id="brand">Ford<br>
      <label for="model">Model: </label><input id="model">Mustang<br>
      <label for="color">Color: </label><input id="color">Black<br>
      <label for="year">Year: </label><input id="year">1973<br>
      <button>Update</button>
      <hr>
    </div>
  </body>
</html> 
```
  
### Edit  
  
Here, similar to new, we want to have some input fields for changing the information that we have stored for a given car. Unlike new, we already have this information, so we can display it somehow.  
  
Perhaps as the value in the input fields.  
  
```html
<!-- included in our show view today -->
```  

## Exercise 01  
  
Now that we have decided on what views we want to support, and roughly what they look like, go ahead and develop our client-side code to support CRUD operations on Cars, using these views.  
   
Starting with a top-down code design approach, we might define some of the functions for displaying the views:  
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>CarList</title>
  </head>
  <body>
    <h1>Car List</h1>
    <div id='displayArea'>
    </div>
    <script>
      // displayIndex() shows a list of cars, in the displayArea div:
      function displayIndex() {}

      // displayNew() shows input fields used to create a new car:
      function displayNew() {}

      // displayShow(carId) takes a carId argument, and shows that car 
      // in a paragraph with editable input fields:
      function displayShowAndEdit(carId) {}
    </script>
  </body>
</html>
```
**Exercise 01) a.** Create a function `getCarsIndex()` that calls the Cars List web api, and returns a list of car objects. Use that within the `displayIndex()` function to display the list of cars in the `displayArea` div.  

```javascript
function getCarsIndex() {
  // call the cars_list web api, and return a list of car objects.
}

function displayIndex() {
  let cars = getCarsIndex();
  // use the cars object to populate the displayArea
  // cars.forEach();
  console.log(cars);
}
```  

Here's how we accomplished this before.
```javascript
function loadIndex(url) {
  fetch(url)
    .then(lol => lol.json())
    .then(cars => {
      cars.forEach(car => {
        let myDiv = document.querySelector('#myDiv');
        let pElement = document.createElement('p');
        let link = document.createElement('a');
        link.setAttribute('href', '#')
        link.textContent = `brand: ${car.brand}, model: ${car.model}, year: ${car.year}, color: ${car.color}`;
        link.setAttribute('onclick', `loadCar("${car.id}");return false;`)
        pElement.appendChild(link)
        myDiv.appendChild(pElement);
        console.log(car);
      })
    })
}
```
This time, we're pulling this out into different functions. Trying to separate the api call frmo the building of the view. We can work on refacting and refining our next step after we get it working, but for now, let's consider a couple of ways we could handle this:  

One is the logic from above:  
```javascript
function getCars() {
  // call the cars_list web api, and return a list of car objects.
  return fetch(url)
    .then(cars => cars.json())
}

// call getCarsIndex, and wait for promise to return, then iterate...
function displayIndex() {
  getCarsIndex()
    // use the cars object to populate the displayArea
    .then((cars) => {
      cars.forEach(car => {
        let myDiv = document.querySelector('#displayArea');
        let pElement = document.createElement('p');
        let link = document.createElement('a');
        link.setAttribute('href', '#')
        link.textContent = `brand: ${car.brand}, model: ${car.model}, year: ${car.year}, color: ${car.color}`;
        link.setAttribute('onclick', `loadCar("${car.id}");return false;`)
        pElement.appendChild(link)
        myDiv.appendChild(pElement);
        console.log(car);
      })
    });
}

displayIndex();
```


One is to reverse the logic from above:
```javascript
// takes a cars argument, and populates the displayArea div
function displayIndex(cars) {
  cars.forEach(car => {
    let myDiv = document.querySelector('#displayArea');
    let pElement = document.createElement('p');
    let link = document.createElement('a');
    link.setAttribute('href', '#')
    link.textContent = `brand: ${car.brand}, model: ${car.model}, year: ${car.year}, color: ${car.color}`;
    link.setAttribute('onclick', `loadCar("${car.id}");return false;`)
    pElement.appendChild(link)
    myDiv.appendChild(pElement);
    console.log(car);
  })
}

function getCarsIndex() {
  // call the cars_list web api, transform the return to json and pass it
  // into displayIndex
  fetch(url)
    .then(lol => lol.json())
    .then(cars => displayIndex(cars));
}

getCarsIndex();
```

**Exercise 01) b.** After going through the process above, we found that we may have a preference to have the function that builds the view, call whatever it needs to call to get the data. Create a function that will create a view for Show & Edit. This function may call another function that returns the required data, or use or reuse data that already exists.  
  
In fact, why don't we try both ways and compare.  
  
