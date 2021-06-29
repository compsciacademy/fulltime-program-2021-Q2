import React, { useState, useEffect} from 'react';
import Loader from './Loader';
import Pending from './Pending';
import Complete from './Complete';

const Home = () => {
  const [todos, setTodos] = useState({});
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const url = '/todos/all_todos';
    fetch(url)
      .then(resp => {
        if (resp.ok) {
            return resp.json();
        }
        throw new Error('Response was not OK');
      })
      .then(resp => {
        setTodos(resp);
        setLoading(false);
      })
      .catch(() => console.log('There was an issue trying to fetch the TODOs'));
  }, []);

  return(
    <div className="vw-100 vh-100 primary-color d-flex justify-content-center">
      <div className="jumobotron jumbotron-fluid bg-transparent">
        <div className="container secondary-color">
          <h1 className="display-4">Todos</h1>
          <p className="lead">A list of things to do!</p>
          <hr className="my-4"/>
          {
            loading ? <Loader /> : (
              <div>
                <Pending pending={todos.incomplete} />
                <hr className="my-4" />
                <Complete complete={todos.complete} />
              </div>
            )
          }
        </div>
      </div>
    </div>
  )
}

export default Home;
