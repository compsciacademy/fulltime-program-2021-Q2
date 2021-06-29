import React from 'react';
import PendingItems from './PendingItems';

const Pending = ({ pending }) => {
  const handleSubmit = (body) => {
    const url = '/todos/update';
    const token = document.querySelector('meta[name="csrf-token"]').content;
    const stringBody = JSON.stringify(body);
  

    fetch(url, {
      method: 'PUT',
      header: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json"
      },
      body: stringBody
    })
    .then(resp => {
      if (resp.ok) {
        return resp.json();
      }
      throw new Error("Unable to get a response")
    })
    .then(resp => {
      console.log(resp);
    })
    .catch(()=> {console.log("Unable to PUT the TODO")})
  }

  return (
    <div>
      <h4>Pending</h4>
      {pending.map((todo, i) => {
        return (
          <PendingItems key={i} todo={todo} handleSubmit={handleSubmit} />
        )
      })}
    </div>
  )
}

export default Pending;
