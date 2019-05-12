import React from 'react'
import {
  BrowserRouter as Router,
  Switch,
  Route
} from 'react-router-dom'


const App = () => (
  <Router>
    <div>
      <Switch>
        <Route exact path='/' render={() => {return 'Hello React!'}} />
      </Switch>
    </div>
  </Router>
);

export default App;