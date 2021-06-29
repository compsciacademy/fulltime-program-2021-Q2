import React from 'react';

const Loader = () => {
  return <div className="d-flex justify-content-center">
    <div className="spinner-boarder" role="status">
      <span className="">Loading...</span>
    </div>
  </div>
}

export default Loader;