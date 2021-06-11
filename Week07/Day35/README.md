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
Shape.prototype.calcPerimeter = function() {
  perimeter = this.sides * this.sideLength;
  console.log(perimeter);
}

// Create a new instance of the Shape class called square. Give it a name of square and a sideLength of 5.
let square = new Shape("square", 4, 5);

// Call your calcPerimeter() method on the instance, to see whether it logs the calculation result to the browser DevTools' console as expected.
square.calcPerimeter();

// Create a new instance of Shape called triangle, with a name of triangle and a sideLength of 3.
let triangle = new Shape('triangle', 3, 3);

// Call triangle.calcPerimeter() to check that it works OK.
triangle.calcPerimeter();

```

---

## Asynchronous-ity

When code executes all at the same time, that's asynchronous. Since JavaScript is ansynchronous, we sometimes want to create blocking code that does something first, and then something else after...
  
In this example, the loop is _blocking_ code, so it executes first, _and then_ the `console.log` that logs `"Goodbyte friends! </3"` is executed.

```javascript
let doSomething = () => {
    for(let i =0; i < 10; i++) {
        console.log("Hello friends! <3");
    }
    console.log("Goodbye friends! </3");
};
```
We can use callback functions that we pass as arguments to achieve this type of behavior, and customize what happens after what...

```javascript
let doSomething = (somethingElse) => {
    for(let i =0; i < 10; i++) {
        console.log("Hello friends! <3");
    }
    somethingElse();
};

doSomething(() =>{
    console.log("I'm all finished!");
})
```
Here we can even create a function that takes two functions, and calls one then the other...

```javascript
let doSomething = (something, somethingElse) => {
    something();
    somethingElse();
};
```

We have an example of using `XMLHttpRequest` and a local file server in the `Examples/Ajax` directory.  
  
## Homework  
  
Resources:
  - [Deep JavaScript: Theory and techniques](https://exploringjs.com/deep-js/)

Have a look at MDN's [Fetching Data](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Fetching_data) as a reference, and see if you can figure out how to communicate between JavaScript on a website and a Sinatra App through an API call.  

[CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)  
  