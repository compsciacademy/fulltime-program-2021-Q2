# Day 35

[Understanding prototype objects](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/Object_prototypes#understanding_prototype_objects). Here's a constructor function --- a function that is used to _construct_ (or create) instances of objects.  
  
```js
function Person(first, last, age, gender, interests) {
  this.name = {
    'first': first,
    'last': last
  }

  this.age = age;
  this.gender = gender;
  this.interests = interests;
}
```
  
You can use a constructor function to create new object instance (instance objects) like so:
```js
let person = new Person('Drew', 'Ogryzek', '44', 'zme/zmaroni', ['books', 'computers', 'chicken', 'ramen'])
```

Add a method to a constructor function: 

```js
Person.prototype.goodbye = function() {
  alert(this.name.first + ' is gone, yo! A. B. Sssseeeeeeeeeee ya!!!!');
};

// then call the method from a Person instance:

person.goodbye()
```

## Exercise 01: Test Your Skills

[OOJS1](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/Test_your_skills:_Object-oriented_JavaScript#oojs_1)

```js
function Shape(name, sides, sideLength) {
  this.name = name;
  this.sides = sides;
  this.sideLength = sideLength;
}

// Write your code below here
// Add a new method to the Shape class's prototype, calcPerimeter(), which calculates its perimeter (the length of the shape's outer edge) and logs the result to the console.


// Create a new instance of the Shape class called square. Give it a name of square and a sideLength of 5.

// Call your calcPerimeter() method on the instance, to see whether it logs the calculation result to the browser DevTools' console as expected.

// Create a new instance of Shape called triangle, with a name of triangle and a sideLength of 3.

// Call triangle.calcPerimeter() to check that it works OK.


```
