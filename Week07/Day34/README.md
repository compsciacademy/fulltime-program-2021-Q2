# Day 34  
  
Some JavaScript Resources:  
  * [MDN JavaScript Reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference)
  * [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Learn/JavaScript)
  * [Eloquent JavaScript](https://eloquentjavascript.net/)
  * [The Modern JavaScript Tutorial](https://javascript.info/)  
  * [EcmaScript Standards](https://www.ecma-international.org/publications-and-standards/standards/ecma-262/)  

    
Some addtional resources:  
  * [can I use](https://caniuse.com/)
  * [HTML Reference](https://developer.mozilla.org/en-US/docs/Web/HTML/Element)

JavaScript is the language of the browser. Typically, _behavior_ that happens in browsers is determined by JavaScript. As such, we can add and use JavaScript within web pages, i.e. HTML.  
  
```html
<!DOCTYPE html>
<title>My Document</title>

<script>
</script>

<h1>My WebPage</h1>
```

## Exercise 01

[Guessing the Number Game](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/First_steps/A_first_splash)  
  
Documentation:  
  * [Math.random](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random)
  * [document.querySelector](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector)
  
```html
<!--
Guess the Number Game
---------------------
  * generate a random number between 1 and 100
  * have the user submit a guess
  * show the guess, and:
    * if the guess is:
      - NaN (Not a Number), then
        * show that it is wrong
        if it was the 10th guess, Game Over
      - too high, then
        * show that it is too high
        if it was the 10th guess, Game Over
      - too low, then
        * show that it is too low
        if it was the 10th guess, Game Over
      - correct, then
        * show that it is correct
          * Game Over
    
  * Game Over:
    - stop the form from acceping input, and give a way to start a new game.  
-->

<label for="guessField"></label><input type="text" id="guessField" class="guessField">
<input type="submit" value="Submit guess" class="guessSubmit">

<div class="resultParams">
  <p class="guesses"></p>
  <p class="lastResult"></p>
  <p class="lowOrHigh"></p>
</div>

<script>

  // generate a random number between 1 and 100
  // let randomNumber = Math.floor(Math.random() * 100) + 1;
  let randomNumber = Math.ceil(Math.random() * 100);
  // console.log('The answer is: ' + randomNumber);
  
  const guesses = document.querySelector('.guesses');
  const lastResult = document.querySelector('.lastResult');
  const lowOrHigh = document.querySelector('.lowOrHigh');
  
  const guessSubmit = document.querySelector('.guessSubmit');
  const guessField = document.querySelector('.guessField');
  
  let guessCount = 1;
  let resetButton;
  
  function checkGuess() {
    let userGuess = Number(guessField.value)
    if (guessCount === 1) {
      guesses.textContent = 'Previous Guesses: ';
    }
    guesses.textContent += userGuess + ' ';
  
    if (userGuess === randomNumber) {
      // win condition
      lastResult.textContent = 'Congratulations. You got it right!';
      lastResult.style.backgroundColor = 'green';
      lowOrHigh.textContent = '';
      setGameOver();
    } else if (guessCount === 10) {
      // loss condition
      lastResult.textContent = '!!!GAME OVER!!!';
      setGameOver();
    } else {
      // default if above conditions are not met
      lastResult.textContent = 'Wrong!';
      lastResult.style.backgroundColor = 'red';
      if (userGuess < randomNumber) {
        lowOrHigh.textContent = 'Last guess was too low!';
      } else if (userGuess > randomNumber){
        lowOrHigh.textContent = 'Last guess was too high!';
      }
    }
  
    guessCount++;
    guessField.value = '';
    guessField.focus();
  }

  function setGameOver() {
    guessField.disabled = true;
    guessSubmit.disabled = true
    resetButton = document.createElement('button');
    resetButton.textContent = 'Start new game';
    document.body.append(resetButton);
    resetButton.addEventListener('click', resetGame);
  }

  function resetGame() {
    guessCount = 1
    const resetParams = document.querySelectorAll('.resultParams p' );
    for (let i = 0; i < resetParams.length; i++) {
      resetParams[i].textContent = '';
    }

    resetButton.parentNode.removeChild(resetButton);

    guessField.disabled = false;
    guessSubmit.disabled = false;
    guessField.value = '';
    guessField.focus()

    randomNumber = Math.ceil(Math.random() * 100);
  }

  guessSubmit.addEventListener('click', checkGuess);
  
  </script>

```

## Events

[A simple example](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Building_blocks/Events#a_simple_example)  
  
```html
<!DOCTYPE html>
<title>Working with Events</title>


<button>Change color</button>
<button>don't change color</button>

<script>
button = document.querySelector('button');

function random(number) {
  return Math.ceil(Math.random() * number);
}

button.onclick = function() {
  const randomColor = `rgb(${random(255)}, ${random(255)}, ${random(255)})`;
  document.body.style.backgroundColor = randomColor;
}

</script>

```

## Homework  
  
Remember the Songs Application that we worked on waaaaaaay back when?  
  
Create a web page that has input to add songs with links, and use an event listener to append new songs to a table of songs that is displayed. You don't have to persist any data through a page reload.  
  