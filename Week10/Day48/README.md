# Day 48

Today, we're looking at [Build Your Own React](https://pomb.us/build-your-own-react/), which is a great resource from Rodrigo Pombo who is quite prolific and always seems to be working on the next cutting edge goodness.  
  
## Step Zero: Review
  
```js
// define a React element
const element = <h1 title="foo">Hello</h1>

// get a node from the DOM
const container = document.getElementById("root")

// render the React element into the container
ReactDOM.render(element, container)
```

Remove React specific code, and produce vanilla JavaScript:
```js
// const element = <h1 title="foo">Hello</h1>
// can become:
const element = {
    type: "h1",
    props: {
        title: "foo",
        children: "Hello",
    },
}

// already vanilla JavaScript
const container = document.getElementById("root")

// ReactDOM.render(element, container)
// can become:
const node = document.createElement(element.type);
node["title"] = element.props.title;

const text = document.createTextNode("");
text["nodeValue"] = element.props.children;

node.appendChild(text);
container.appendChild(node);
```

## Step 1: The `createElement` Function

```js
const element = (
  <div id="lol">
    <a>hey</a>
    <br />
  </div>
)

const container = document.getElementById("root");
ReactDOM.render(element, container);
```

```js
// a function to create an element:
// e.g.
const element = React.createElement( 
  "div", 
  {"id": "lol"},
  React.createElement("a", "null", "hey"),
  React.createElement("br");
)
```

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

const Didact = {
  createElement,
}

const element = Didact.createElement()

/** @jsx Didact.createElement */
const element = (
  <div id='lol'>
    <a>hey</a>
    <hr />
  <div>
)
```

## Step 2: The `render` Function

```js
function render(element, container) {
  const dom = 
    element.type === "TEXT_ELEMENT" 
      ? document.createTextNode("") 
      : document.createElement(element.type);

  const isProperty = key => key !== "children" 
  Object.keys(element.props)
    .filter(isProperty)
    .forEach(name => {
      dom[name] = element.props[name]
    })

  element.props.children.forEach(child => 
    render(child, dom);
  )
  container.appendChild(dom);
}

const Didact = {
  createElement,
  render,
}

Didact.render(element, container)
```

## Step 3: Concurrent Mode  
  
```js
let nextUnitOfWork = null;

function workLoop(deadline) {
  let shouldYield = false;
  while (nextUnitOfWork && !shouldYield) {
    nextUnitOfWork = performUnitOfWork(nextUnitOfWork)
    shouldYield = deadline.timeRemaining() < 1
  }

  requestIdleCallback(workLoop);
}

requestIdleCallback(workLoop);

function performUnitOfWork(nextUnitOfWork) {
  // TODO: make this work
}

```

## Step 4: Fibers  


```js
// refactor some of the code.
// We can pull out the createDom function from Render
function createDom(fiber) {
  const dom = 
    fiber.type === "TEXT_ELEMENT" 
      ? document.createTextNode("") 
      : document.createElement(fiber.type);

  const isProperty = key => key !== "children" 
  Object.keys(fiber.props)
    .filter(isProperty)
    .forEach(name => {
      dom[name] = fiber.props[name]
    })
    return dom;
}

// and refactor render to
function render(element, container) {
  nextUnitOfWork = {
    dom: container,
    props: {
      children: [element],
    }

  }
}

// And let's have a look at performUnitOfWork
function performUnitOfWork(fiber) {
  if (!fiber.dom) {
    fiber.dom = createDom(fiber);
  }

  if (fiber.parent) {
    fiber.parent.dom.appendChild(fiber);
  }

  const elements = fiber.props.children;
  let index = 0;
  let prevSibling = null;

  while (index < elements.length) {
    const element = elements[index];

    const newFiber = {
      type: element.type,
      props: element.props,
      parent: fiber,
      dom: null,
    }

    if (index === 0) {
      fiber.child = newFiber;
    } else {
      prevSibling.sibling = newFiber;
    }

    prevSibling = newFiber;
    index++;
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

```

## Step 5: Render and Commit Phases  

The `performUnitOfWork` function will append a new node to the DOM everytime we work on an element:
```js
  if (fiber.parent) {
    fiber.parent.dom.appendChild(fiber);
  }
```

This might not be what we want, so remove that part.

```js
// And let's have a look at performUnitOfWork
function performUnitOfWork(fiber) {
  if (!fiber.dom) {
    fiber.dom = createDom(fiber);
  }

  if (fiber.parent) {
    fiber.parent.dom.appendChild(fiber);
  }

  const elements = fiber.props.children;
  let index = 0;
  let prevSibling = null;

  while (index < elements.length) {
    const element = elements[index];

    const newFiber = {
      type: element.type,
      props: element.props,
      parent: fiber,
      dom: null,
    }

    if (index === 0) {
      fiber.child = newFiber;
    } else {
      prevSibling.sibling = newFiber;
    }

    prevSibling = newFiber;
    index++;
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
```

That means that in our Render function, rather than use `nextUnitOfWork`, we are going to call this a Work In Progress Root, (`wipRoot`) because somehow changing its name is meaningful.  
  
```js

function render(element, container) {
  wipRoot = {
    dom: container,
        props: {
          children: [element],
        }
      }
  nextUnitOfWork = wipRoot;
}

let wipRoot = null;

```

Now that we've essentially allowed the building of nodes / elements / dom objects to not block, but yield to the browser, we can ensure that they are all _appended_ at once.  
  
```js
function commitRoot() {
  // add nodes to DOM
}

```
Modify the `workLoop` function to use the `commitRoot()` function that will commit all dom elements after there is nomore `nextUnitOfWork` to be added.  
  
```js
function workLoop(deadline) {
  let shouldYield = false;
  while (nextUnitOfWork && !shouldYield) {
    nextUnitOfWork = performUnitOfWork(nextUnitOfWork)
    shouldYield = deadline.timeRemaining() < 1
  }

  if (!nextUnitOfWork && wipRoot) {
    commitRoot();
  }

  requestIdleCallback(workLoop);
}
```

## Step 6: Reconciliation  
  
```js

function commitRoot() {
  deletions.forEach(commitWork)
  commitWork(wipRoot.child)
  currentRoot = wipRoot;
  wipRoot = null;
}

function commitWork(fiber) {
  if(!fiber) {
    return
  }
  
  const domParent = fiber.parent.dom;
  if (
    fiber.effectTag === "PLACEMENT" &&
    fiber.dom != null
  ) {
    domParent.appendChild(fiber.dom);
  } else if (fiber.effectTag === "DELETION") {
    domParent.removeChild(fiber.dom); 
  } else if (
    fiber.effectTag === "UPDATE" &&
    fiber.dom != null
  ) {
    updateDom(
      fiber.dom,
      fiber.alternate.props,
      fiber.props
    );
  }

  commitWork(fiber.child);
  commitWork(fiber.sibling);
}

```

Add a `alternate` property to the `render` method that sets the wipRoot's `alternate` to the last rendered to the DOM DOM object for that fiber/dom/element.  
  
```js
function render(element, container) {
  wipRoot = {
    dom: container,
    props: {
      children: [element],
    },
    alternate: currentRoot;
  }

  deletions = [];
  nextUnitOfWork = wipRoot;
}
```

and update the initalized variables with `currentRoot`
```js
  // general use varibles
  const elements = fiber.props.children;
  let index = 0;
  let prevSibling = null;
  let nextUnitOfWork = null;
  let currentRoot = null;
  let wipRoot = null;
  let deletions = null;
```

Extract the code from `performUnitOfWork` to a `reconcileChildren` function: 
```js
// we can remove this from performUnitOfWork: 
  let index = 0;
  let prevSibling = null;

  while (index < elements.length) {
    const element = elements[index];

    const newFiber = {
      type: element.type,
      props: element.props,
      parent: fiber,
      dom: null,
    }

    if (index === 0) {
      fiber.child = newFiber;
    } else {
      prevSibling.sibling = newFiber;
    }

    prevSibling = newFiber;
    index++;
  }

// performUnitOfWork can become:
function performUnitOfWork(fiber) {
  if (!fiber.dom) {
    fiber.dom = createDom(fiber);
  }

  const elements = fiber.props.children
  // new code
  reconcileChildren(fiber, elements);

  // old code cont...
  if (fiber.child) {
    return fiber.child;
  }

  let nextFiber = fiber
  while (nextFiber) {
    if (nextFiber.sibling) {
      return nextFiber.sibling
    }
    nextFiber = nextFiber.parent
  }
}

// and of course the reconcileChildren function 
function reconcileChildren(wipFiber, elements) {
  let index = 0;
  let oldFiber = wipFiber.alternate && wipFiber.alternate.child
  let prevSibling = null;

  while (
    index < elements.length || 
    oldFiber != null
  ) {
    const element = elements[index];
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
      oldFiber.effectTag = "DELETION";
      deletions.push(oldFiber);
    }
  }
}
```

and we need an `updateDom` function that takes 3 arguments
```js
const isEvent = key => key.startsWith("on")
const isProperty = key => 
  key !== "children" && !isEvent(key)
const isNew = (prev, next) => key => prev[key] !== next[key]
const isGone = (prev, next) => key => !(key in next)

function updateDom(dom, prevProps, nextProps) {
  // remove old or changed event listeners
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

  // add event listeners
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

  // remove old properties
  Object.keys(prevProps)
    .filter(isProperty)
    .filter(isGone(prevProps, nextProps))
    .forEach(name => {
      dom[name] = "";
    })

  // set new or changed properties
  Object.keys(nextProps)
    .filter(isProperty)
    .filter(isNew(prevProps, nextProps))
    .forEach(name => {
      dom[name] = nextProps[name]
    })

}
```

## Step 7: Function Components