# Day 50  
  
Something that might be nice is to build out a clock using JavaScript. Let's have a look into how we might do this in Vanilla JavaScript, then Didact/React as a component and _why_, and let's look at how else we might do it. I.e. let's start with a simple digital representation of time, and then an analog (looking) version.  
    
## Exercise 01  
  
Write some JavaScript that displays the current time to an HTML page. It should display in this format: HH:MM:SS, where it is updating _at least_ per second.  
  
```html
<!DOCTYPE html>
<meta charset="utf-8">
<title>My Clock</title>

<body>
  <div id="root">
  </div>
</body>
<script>
  let container = document.getElementById("root");

  function displayTime() {
    let date = new Date();
    let hour = date.getHours();
    let minutes = date.getMinutes();
    let seconds = date.getSeconds();
    let time = `${hour}:${minutes}:${seconds} ${amOrPm(hour)}`;
    container.textContent = time;
  }

  function amOrPm(hour) {
      return hour >= 12 ? "PM" : "AM"
  }

  setInterval(displayTime, 1000);
</script>

```

What if we want to add milliseconds to our clock? What should we do.

We can simply add:

```js
// a variable to hold the current milliseconds in the function call
let milliseconds = date.getMilliseconds();

// add it in the output display:
let time = `${hour}:${minutes}:${seconds}:${milliseconds} ${amOrPm(hour)}`;

// and change the argument to `setInterval` to update faster
setInterval(displayTime, 10);
```

## Exercise 02

That's a pretty cool digital clock. Of course, we could make it look nicer, but it does work. What if we wanted to have an analog clock instead? You know, the type with hour and minute hands, and even a seconds hand?  
  
How would we do that?
  
The [`rotate()` CSS function](https://developer.mozilla.org/en-US/docs/Web/CSS/transform-function/rotate()) can come in quite handy here.  
  
Let's start out with defining the HTML  
  
```html
<!DOCTYPE html>
<meta charset="utf-8">
<title>Analog Clock</title>

<body>
  <div class="container">
    <div id="hour"></div>
    <div id="minute"></div>
    <div id="second"></div>
  </div>
</body>

```

We can use this [clock.png](https://e7.pngegg.com/pngimages/449/884/png-clipart-clock-face-digital-clock-time-clock-angle-white.png) as a background image for the `container` div, and that will free us up from spending time on trying to make one with CSS.  
  

