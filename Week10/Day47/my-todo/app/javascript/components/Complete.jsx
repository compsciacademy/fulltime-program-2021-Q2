import React from 'react';

const Complete = ({ complete, handleSubmit }) => {
  const handleCompleteChange = () => {
    // handle the change from comlpete: true to false for
    // items in the complete component.
  }

  return (
    <div>
      <h4>Complete</h4>
      { complete.map((todo, i) => {
        return (
          <div className="form-check" key={i}>
            <input className="form-check-input" type="checkbox" onChange={handleCompleteChange} checked={todo.complete} value="" id={`checkbox${todo.id}`}/>
            <label className="form-check-label" htmlFor={`checkbox${todo.id}`}>{todo.title}</label>
          </div>
        )
      })}
    </div>
  )
}

export default Complete;