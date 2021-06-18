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
  