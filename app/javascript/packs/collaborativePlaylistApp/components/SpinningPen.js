import React, { Component } from 'react';
import EditIcon from '@material-ui/icons/Edit';
import '../assets/stylesheets/spin.css';

class SpinningPen extends Component {
  render() {
    return (
      <EditIcon style={{animation: `spin 3s linear infinite`}} />
    )
  }
}

export default SpinningPen;