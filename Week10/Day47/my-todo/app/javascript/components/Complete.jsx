import React from 'react';

const Complete = ({ complete }) => {
  return (
    <div>
      <h4>Complete</h4>
      { complete.map((todo, i) => {
        return (
          <div class="form-check" key={i}>
            <input class="form-check-input" type="checkbox" checked={todo.complete} value="" id={`checkbox${todo.id}`}/>
            <label class="form-check-label" for={`checkbox${todo.id}`}>{todo.title}</label>
          </div>
        )
      })}
    </div>
  )
}

export default Complete;