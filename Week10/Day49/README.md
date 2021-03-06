# Day 49  

We have been looking at [Build Your Own React](), and here is where we are so far:

```js
function createElement(type, props, ...children) {
  return {
    type,
    props: {
      ...props,
      children: children.map(child =>
        typeof child === "object"
          ? child
          : createTextElement(child)
      ),
    },
  }
}

function createTextElement(text) {
  return {
    type: "TEXT_ELEMENT",
    props: {
      nodeValue: text,
      children: [],
    },
  }
}

function createDom(fiber) {
  const dom =
    fiber.type == "TEXT_ELEMENT"
      ? document.createTextNode("")
      : document.createElement(fiber.type)

  updateDom(dom, {}, fiber.props)

  return dom
}

const isEvent = key => key.startsWith("on")
const isProperty = key =>
  key !== "children" && !isEvent(key)
const isNew = (prev, next) => key =>
  prev[key] !== next[key]
const isGone = (prev, next) => key => !(key in next)
function updateDom(dom, prevProps, nextProps) {
  //Remove old or changed event listeners
  Object.keys(prevProps)
    .filter(isEvent)
    .filter(
      key =>
        !(key in nextProps) ||
        isNew(prevProps, nextProps)(key)
    )
    .forEach(name => {
      const eventType = name
        .toLowerCase()
        .substring(2)
      dom.removeEventListener(
        eventType,
        prevProps[name]
      )
    })

  // Remove old properties
  Object.keys(prevProps)
    .filter(isProperty)
    .filter(isGone(prevProps, nextProps))
    .forEach(name => {
      dom[name] = ""
    })

  // Set new or changed properties
  Object.keys(nextProps)
    .filter(isProperty)
    .filter(isNew(prevProps, nextProps))
    .forEach(name => {
      dom[name] = nextProps[name]
    })

  // Add event listeners
  Object.keys(nextProps)
    .filter(isEvent)
    .filter(isNew(prevProps, nextProps))
    .forEach(name => {
      const eventType = name
        .toLowerCase()
        .substring(2)
      dom.addEventListener(
        eventType,
        nextProps[name]
      )
    })
}

function commitRoot() {
  deletions.forEach(commitWork)
  commitWork(wipRoot.child)
  currentRoot = wipRoot
  wipRoot = null
}

function commitWork(fiber) {
  if (!fiber) {
    return
  }

  const domParent = fiber.parent.dom
  if (
    fiber.effectTag === "PLACEMENT" &&
    fiber.dom != null
  ) {
    domParent.appendChild(fiber.dom)
  } else if (
    fiber.effectTag === "UPDATE" &&
    fiber.dom != null
  ) {
    updateDom(
      fiber.dom,
      fiber.alternate.props,
      fiber.props
    )
  } else if (fiber.effectTag === "DELETION") {
    domParent.removeChild(fiber.dom)
  }

  commitWork(fiber.child)
  commitWork(fiber.sibling)
}

function render(element, container) {
  wipRoot = {
    dom: container,
    props: {
      children: [element],
    },
    alternate: currentRoot,
  }
  deletions = []
  nextUnitOfWork = wipRoot
}

let nextUnitOfWork = null
let currentRoot = null
let wipRoot = null
let deletions = null

function workLoop(deadline) {
  let shouldYield = false
  while (nextUnitOfWork && !shouldYield) {
    nextUnitOfWork = performUnitOfWork(
      nextUnitOfWork
    )
    shouldYield = deadline.timeRemaining() < 1
  }

  if (!nextUnitOfWork && wipRoot) {
    commitRoot()
  }

  requestIdleCallback(workLoop)
}

requestIdleCallback(workLoop)

function performUnitOfWork(fiber) {
  if (!fiber.dom) {
    fiber.dom = createDom(fiber)
  }

  const elements = fiber.props.children
  reconcileChildren(fiber, elements)

  if (fiber.child) {
    return fiber.child
  }
  let nextFiber = fiber
  while (nextFiber) {
    if (nextFiber.sibling) {
      return nextFiber.sibling
    }
    nextFiber = nextFiber.parent
  }
}

function reconcileChildren(wipFiber, elements) {
  let index = 0
  let oldFiber =
    wipFiber.alternate && wipFiber.alternate.child
  let prevSibling = null

  while (
    index < elements.length ||
    oldFiber != null
  ) {
    const element = elements[index]
    let newFiber = null

    const sameType =
      oldFiber &&
      element &&
      element.type == oldFiber.type

    if (sameType) {
      newFiber = {
        type: oldFiber.type,
        props: element.props,
        dom: oldFiber.dom,
        parent: wipFiber,
        alternate: oldFiber,
        effectTag: "UPDATE",
      }
    }
    if (element && !sameType) {
      newFiber = {
        type: element.type,
        props: element.props,
        dom: null,
        parent: wipFiber,
        alternate: null,
        effectTag: "PLACEMENT",
      }
    }
    if (oldFiber && !sameType) {
      oldFiber.effectTag = "DELETION"
      deletions.push(oldFiber)
    }

    if (oldFiber) {
      oldFiber = oldFiber.sibling
    }

    if (index === 0) {
      wipFiber.child = newFiber
    } else if (element) {
      prevSibling.sibling = newFiber
    }

    prevSibling = newFiber
    index++
  }
}

const Didact = {
  createElement,
  render,
}

/** @jsx Didact.createElement */
const container = document.getElementById("root")

const updateValue = e => {
  rerender(e.target.value)
}

const rerender = value => {
  const element = (
    <div>
      <input onInput={updateValue} value={value} />
      <h2>Hello {value}</h2>
    </div>
  )
  Didact.render(element, container)
}

rerender("World")
```

## Exercise 1

Let's step though some of this, and prove it out, or at least make sure we can wrap our heads around it.
  
In the `updateDom` function, there is some code to remove old event listeners:
```js
  Object.keys(prevProps)
    .filter(isEvent)
    .filter(
      key =>
        !(key in nextProps) ||
        isNew(prevProps, nextProps)(key)
    )
    .forEach(name => {
      const eventType = name
        .toLowerCase()
        .substring(2)
      dom.removeEventListener(
        eventType,
        prevProps[name]
      )
    })
```

Why does it call `isNew`? which is a filter defined as such:
```js
const isNew = (prev, next) => key => prev[key] !== next[key]
```

1.) Write some code that shows whether this is accurate, and why. Use it with some _words_ to explain.

```js
// initialize a couple of objects:
let objOld = {a: "one", b: "two", c: "three", d: "different"}
let objNew = {a: "one", b: "two", c: "three", e: "five", f: "six"}

// In this case, we expect `d: "different"` to be recognized as old.
// Let's iterate over the keys in objOld, and use filters to find
// just `d`

Object.keys(objOld)
  .filter(key => 
    // if the key from objOld is not in objNew or
    !(key in objNew) ||
    // if the objOld[key] is not equal to objNew[key]
    isNew(objOld, objNew)(key)
  )
  // log each key that passes those filters to the console   
  .forEach(name => console.log(name))

// That returns d.
```
  
2.) Now, try again, but this time instead of using `!(key in objNew) || isNew(objOld, objNew)(key)` as a filter, separate each side of the `||` into a single filter, and give an example of each of them logging a name to the console.  
```js
// This satisfies the first condition, without any changes to
// the example objects, because there is an old key from 
// objOld (d) that is not present in objNew
Object.keys(objOld)
  .filter(key =>
    !(key in objNew)
  ).forEach(name => console.log(name))

```

```js
const isNew = (prev, next) => key => prev[key] !== next[key]
// This time, using the same example objects will return no results,
// so we must change the examples to satisfy the condition.
let objOld = {a: "one", b: "two", c: "three", f: 'hey'}
let objNew = {a: "one", b: "five", c: "three", e: 'lol'}
Object.keys(objOld)
  .filter(key => 
    isNew(objOld, objNew)(key)
  ).forEach(name => console.log(name))

// This returns b and f, because both of the _values_ for 
// those keys are different.
```

What have we learned from this exercise? Hopefully, it has become clear that `!(key in objNew) || isNew(objOld, objNew)(key)` is doing two things:
  1. If a key exists in the old object, but not the new object (the left side of the `||` evaluation), it will return that key.
  2. If a key exists in both objects, but the values are different (the right side of the `||` evaluation), it will return that key.

This means that if we change the example objects to have both different keys, and different values with same keys, we will expect all of the keys that meet those requirements to be logged to the console:

```js
const isNew = (prev, next) => key => prev[key] !== next[key]
// initialize a couple of objects:
let objOld = {a: "one", b: "too", c: "three", d: "different", g: "surprise"}
let objNew = {a: "won", b: "two", c: "three", e: "five", f: "six"}

Object.keys(objOld)
  .filter(key => 
    !(key in objNew) ||
    isNew(objOld, objNew)(key)
  )
  .forEach(name => console.log(name))

// Here we expect the results to be:
// a, b, d, g
```

## Step 7: Function Components

Function Components are a different in a couple of ways, one is that the fiber from a function component does not have a DOM node, and the other is that rather than getting the children from the `props`, they come from running the function.  
  
```js
/*** @jsx Didact.createElement **/
function App(props) {
  return <h1>Hi {props.name}</h1>
}

const element = <App name="foo" />
const container = document.getElementById("root")
Didact.render(element, container)

// transforming this JSX to JavaScript looks like
function App(props) {
  return Didact.createElement(
    "h1",
    null,
    "Hi ",
    props.name
  )
}

const element = Didact.createElement(App, {name: "foo" })
```

So, now we update our `performUnitOfWork` function to see if the fiber is a functionComponent

```js
function performUnitOfWork(fiber) {
  const isFunctionComponent = fiber.type instanceOf Function
  if (isFunctionComponent) {
    updateFunctionComponent(fiber)
  } else {
    updateHostComponent(fiber)
  }

  if (fiber.child) {
    return fiber.child
  }
  let nextFiber = fiber
  while (nextFiber) {
    if (nextFiber.sibling) {
      return nextFiber.sibling
    }
    nextFiber = nextFiber.parent
  }
}

function updateFunctionComponent(fiber) {
  const children = [fiber.type(fiber.props)]
  reconcileChildren(fiber, children)
}

function updateHostComponent(fiber) {
  if (!fiber.dom) {
    fiber.dom = createDom(fiber)
  }
  reconcileChildren(fiber, fiber.props.children)
}
```

Now that we have some fibers without DOM nodes, we need to change the `commitWork` function to traverse the DOM tree upwards in order to find a parent fiber with a DOM node, and set it as the `domParent` and likewise we add a recursive function that will traverse the DOM tree downwards to find a child with a DOM node to be removed if selected for DELETION.  

```js
function commitWork(fiber) {
  if (!fiber) {
    return
  }

  let domParentFiber = fiber.parent
  while (!domParentFiber.dom) {
    domParentFiber = domParentFiber.parent
  }
  const domParent = domParentFiber.dom

  if (
    fiber.effectTag === "PLACEMENT" &&
    fiber.dom != null
  ) {
    domParent.appendChild(fiber.dom)
  } else if (
    fiber.effectTag === "UPDATE" &&
    fiber.dom != null
  ) {
    updateDom(
      fiber.dom,
      fiber.alternate.props,
      fiber.props
    )
  } else if (fiber.effectTag === "DELETION") {
    commitDeletion(fiber, domParent)
  }

  commitWork(fiber.child)
  commitWork(fiber.sibling)
}

function commitDeletion(fiber, domParent) {
  if (fiber.dom) {
    domParent.removeChild(fiber.dom)
  } else {
    commitDeletion(fiber.child, domParent)
  }
}
```

## Step 8: Hooks  

Let's talk about hooks, which is what we will use to handle state changes.  

We'll look at a counter component that increments by one each time it is clicked.  

## Exercise 03

1.) Have a look at this counter code. Try running it in your browser. Does it work? Why or why not?  
  

```js
/** @jsx Didact.createElement */
function Counter() {
  const [state, setState] = Didact.useState(1)
  return(
    <h1 onClick={()=> setState(c => c + 1)}>count: {state}</h1>
  )
}
const element = <Counter />
const container = document.getElementById("root");
Didact.render(element, container)
```

2.) What happens if you remove the references to Didact? e.g. `Didact.render()` changes to `React.render()`. Does that work? Why or why not?

To answer question 1, we can set up an HTML page with the script:

```html
<!DOCTYPE html>
<meta charset="UTF-8">
<title>Counter</title>

<body>
  <div id="root">
  </div>
</body>

<script>
/** @jsx Didact.createElement */
function Counter() {
  const [state, setState] = Didact.useState(1)
  return(
    <h1 onClick={()=> setState(c => c + 1)}>count: {state}</h1>
  )
}
const element = <Counter />
const container = document.getElementById("root");
Didact.render(element, container)
</script>
```
We first get an error that there is an unexpected `<` because the JavaScript interpreter doesn't know what to do with that. Of course, we can remember that Babel can interpret it for us, so we need to do a couple of things:  
  - import babel
  - add `type="text/babel"` as a script element attribute.
```html
<!-- babel -->
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>

<script type="text/babel">
// ...
</script>

<!-- ... -->
```
We then get an error message that `Didact` does not exist. We could potentially resolve this by importing the code we have above that defines Didact.  
  
---

As for question 2, we have the same issue when we change the references to Didact to React. React does not exist (in our code base).

```html
<!DOCTYPE html>
<meta charset="UTF-8">
<title>Counter</title>

<body>
  <div id="root">
  </div>
</body>

<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>

<script type="text/babel">
/** @jsx React.createElement */
function Counter() {
  const [state, setState] = React.useState(1)
  return(
    <h1 onClick={()=> setState(c => c + 1)}>count: {state}</h1>
  )
}
const element = <Counter />
const container = document.getElementById("root");
React.render(element, container)
</script>
```

We can resolve that first part by importing react: 
```html
<script src="https://unpkg.com/react@17/umd/react.development.js"></script>
```

We then see that `React.render` is not a `React` function. Some GoogleFu shows that what we need is `ReactDOM`, so we can import that as well, and update the call to `render()`

```html
<!-- react dom -->
<script src="https://unpkg.com/react-dom@17/umd/react-dom.development.js"></script>
<!-- ... -->
<script type="text/babel">
  // ...
  ReactDOM.render(element, container)
</script>
```

And that works.

---

3.) Resolve the issues for question one, such that it works.

To answer this question, we just put the Didact source into its own file, `didact.js`, import it as source, remove any React/ReactDOM references, replacing them with the appropriate Didact references, including `/** @jsx Didact.createElement */`

```javascript
function createElement(type, props, ...children) {
    return {
      type,
      props: {
        ...props,
        children: children.map(child =>
          typeof child === "object" ? child : createTextElement(child)
        )
      }
    };
  }
  
  function createTextElement(text) {
    return {
      type: "TEXT_ELEMENT",
      props: {
        nodeValue: text,
        children: []
      }
    };
  }
  
  function createDom(fiber) {
    const dom =
      fiber.type == "TEXT_ELEMENT"
        ? document.createTextNode("")
        : document.createElement(fiber.type);
  
    updateDom(dom, {}, fiber.props);
  
    return dom;
  }
  
  const isEvent = key => key.startsWith("on");
  const isProperty = key => key !== "children" && !isEvent(key);
  const isNew = (prev, next) => key => prev[key] !== next[key];
  const isGone = (prev, next) => key => !(key in next);
  function updateDom(dom, prevProps, nextProps) {
    //Remove old or changed event listeners
    Object.keys(prevProps)
      .filter(isEvent)
      .filter(key => !(key in nextProps) || isNew(prevProps, nextProps)(key))
      .forEach(name => {
        const eventType = name.toLowerCase().substring(2);
        dom.removeEventListener(eventType, prevProps[name]);
      });
  
    // Remove old properties
    Object.keys(prevProps)
      .filter(isProperty)
      .filter(isGone(prevProps, nextProps))
      .forEach(name => {
        dom[name] = "";
      });
  
    // Set new or changed properties
    Object.keys(nextProps)
      .filter(isProperty)
      .filter(isNew(prevProps, nextProps))
      .forEach(name => {
        dom[name] = nextProps[name];
      });
  
    // Add event listeners
    Object.keys(nextProps)
      .filter(isEvent)
      .filter(isNew(prevProps, nextProps))
      .forEach(name => {
        const eventType = name.toLowerCase().substring(2);
        dom.addEventListener(eventType, nextProps[name]);
      });
  }
  
  function commitRoot() {
    deletions.forEach(commitWork);
    commitWork(wipRoot.child);
    currentRoot = wipRoot;
    wipRoot = null;
  }
  
  function commitWork(fiber) {
    if (!fiber) {
      return;
    }
  
    let domParentFiber = fiber.parent;
    while (!domParentFiber.dom) {
      domParentFiber = domParentFiber.parent;
    }
    const domParent = domParentFiber.dom;
  
    if (fiber.effectTag === "PLACEMENT" && fiber.dom != null) {
      domParent.appendChild(fiber.dom);
    } else if (fiber.effectTag === "UPDATE" && fiber.dom != null) {
      updateDom(fiber.dom, fiber.alternate.props, fiber.props);
    } else if (fiber.effectTag === "DELETION") {
      commitDeletion(fiber, domParent);
    }
  
    commitWork(fiber.child);
    commitWork(fiber.sibling);
  }
  
  function commitDeletion(fiber, domParent) {
    if (fiber.dom) {
      domParent.removeChild(fiber.dom);
    } else {
      commitDeletion(fiber.child, domParent);
    }
  }
  
  function render(element, container) {
    wipRoot = {
      dom: container,
      props: {
        children: [element]
      },
      alternate: currentRoot
    };
    deletions = [];
    nextUnitOfWork = wipRoot;
  }
  
  let nextUnitOfWork = null;
  let currentRoot = null;
  let wipRoot = null;
  let deletions = null;
  
  function workLoop(deadline) {
    let shouldYield = false;
    while (nextUnitOfWork && !shouldYield) {
      nextUnitOfWork = performUnitOfWork(nextUnitOfWork);
      shouldYield = deadline.timeRemaining() < 1;
    }
  
    if (!nextUnitOfWork && wipRoot) {
      commitRoot();
    }
  
    requestIdleCallback(workLoop);
  }
  
  requestIdleCallback(workLoop);
  
  function performUnitOfWork(fiber) {
    const isFunctionComponent = fiber.type instanceof Function;
    if (isFunctionComponent) {
      updateFunctionComponent(fiber);
    } else {
      updateHostComponent(fiber);
    }
    if (fiber.child) {
      return fiber.child;
    }
    let nextFiber = fiber;
    while (nextFiber) {
      if (nextFiber.sibling) {
        return nextFiber.sibling;
      }
      nextFiber = nextFiber.parent;
    }
  }
  
  let wipFiber = null;
  let hookIndex = null;
  
  function updateFunctionComponent(fiber) {
    wipFiber = fiber;
    hookIndex = 0;
    wipFiber.hooks = [];
    const children = [fiber.type(fiber.props)];
    reconcileChildren(fiber, children);
  }
  
  function useState(initial) {
    const oldHook =
      wipFiber.alternate &&
      wipFiber.alternate.hooks &&
      wipFiber.alternate.hooks[hookIndex];
    const hook = {
      state: oldHook ? oldHook.state : initial,
      queue: []
    };
  
    const actions = oldHook ? oldHook.queue : [];
    actions.forEach(action => {
      hook.state = action(hook.state);
    });
  
    const setState = action => {
      hook.queue.push(action);
      wipRoot = {
        dom: currentRoot.dom,
        props: currentRoot.props,
        alternate: currentRoot
      };
      nextUnitOfWork = wipRoot;
      deletions = [];
    };
  
    wipFiber.hooks.push(hook);
    hookIndex++;
    return [hook.state, setState];
  }
  
  function updateHostComponent(fiber) {
    if (!fiber.dom) {
      fiber.dom = createDom(fiber);
    }
    reconcileChildren(fiber, fiber.props.children);
  }
  
  function reconcileChildren(wipFiber, elements) {
    let index = 0;
    let oldFiber = wipFiber.alternate && wipFiber.alternate.child;
    let prevSibling = null;
  
    while (index < elements.length || oldFiber != null) {
      const element = elements[index];
      let newFiber = null;
  
      const sameType = oldFiber && element && element.type == oldFiber.type;
  
      if (sameType) {
        newFiber = {
          type: oldFiber.type,
          props: element.props,
          dom: oldFiber.dom,
          parent: wipFiber,
          alternate: oldFiber,
          effectTag: "UPDATE"
        };
      }
      if (element && !sameType) {
        newFiber = {
          type: element.type,
          props: element.props,
          dom: null,
          parent: wipFiber,
          alternate: null,
          effectTag: "PLACEMENT"
        };
      }
      if (oldFiber && !sameType) {
        oldFiber.effectTag = "DELETION";
        deletions.push(oldFiber);
      }
  
      if (oldFiber) {
        oldFiber = oldFiber.sibling;
      }
  
      if (index === 0) {
        wipFiber.child = newFiber;
      } else if (element) {
        prevSibling.sibling = newFiber;
      }
  
      prevSibling = newFiber;
      index++;
    }
  }
  
  const Didact = {
    createElement,
    render,
    useState
  };
```

```html
<!DOCTYPE html>
<meta charset="UTF-8">
<title>Counter</title>

<body>
  <div id="root">
  </div>
</body>

<!-- imports -->
<!-- babel -->
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
<!-- didact -->
<script src="didact.js"></script>

<script type="text/babel">
/** @jsx Didact.createElement */
function Counter() {
  const [state, setState] = Didact.useState(1)
  return(
    <h1 onClick={() => setState(c => c + 1)}>count: {state}</h1>
  )
}

const element = <Counter />
const container = document.getElementById("root");
Didact.render(element, container)
</script>
```

---  

Now that we've seen how `useState` behaves in action, let's take a look at the building blocks. We've already discussed the main differences between `functionComponents` and `hostComponents`, one of which being that we get `functionComponent` children from calling the function.  
  
Since we want to use some variables inside the `useState` function, we can initialize them as globals before the function gets called in `updateFunctionComponent`:

```js

let wipFiber = null
// we are going to add a hooks array to the wipFiber, and we 
// use hookIndex to keep track of the current hook index, which
// is based on how many times we have called useState.
let hookIndex = null

function updateComponentFiber(fiber) {
  wipFiber = fiber
  hookIndex = 0
  wipFiber.hooks = []
  
  const children = [fiber.type(fiber.props)]
  reconcileChildren(fiber, children)
}

```

Now, we need our `useState` function. We want to check the _alternate_ fiber (the fiber that represents the current dom element), and check its `hooks[hookIndex]`. If it has state, we want to copy that state to the new fiber, if it doesn't, we will initialize the state of the new fiber.  
  
```js
function useState(initial) {
  const oldHook = 
    wipFiber.alternate &&
    wipFiber.alternate.hooks &&
    wipFiber.alternate.hooks[hookIndex]
  const hook = {
    state: oldHook ? oldHook.state : initial,
    queue: [],
  }

  const setState = action => {
    hook.queue.push(action)
    wipRoot = {
      dom: currentRoot.dom,
      props: currentRoot.props,
      alternate: currentRoot,
    }
    nextUnitOfWork = wipRoot
    deletions = []
  }

  wipFiber.hooks.push(hook)
  hookIndex++
  return [hook.state, setState]
}
```

So now, we've looked at enough of how to build out our own version of react to be able to use `React.createElement`, `React.setState`, `ReactDOM.render` and have some inner knowledge of how they (might) function.
  
It was kind of a lot to go over, and a bit of a whirlwind tour. Phew!  
  
## Exercise 04/Homework  

Now, that we have a library (`Didact`) that we can use in place of React, have a look at the TODOs app we made the other day, and perhaps reference some other online materials, and build out a TODOs app using Didact.  

Some Reference Materials: 
  * [MSDN - TODOs](https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Client-side_JavaScript_frameworks/React_todo_list_beginning)  
  * [OpenSource.com - TODOs](https://opensource.com/article/21/3/react-app-hooks)
  * [DigitalOcean - TODOs](https://www.digitalocean.com/community/tutorials/how-to-build-a-react-to-do-app-with-react-hooks)
