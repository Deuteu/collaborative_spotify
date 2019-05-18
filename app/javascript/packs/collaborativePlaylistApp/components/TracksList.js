import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';

const styles = {
  root: {
    width: '100%',
    overflowX: 'auto',
  },
  table: {
    minWidth: 700,
  },
};

class TracksList extends Component {
  static propTypes = {
    tracks: PropTypes.array.isRequired,
  };

  constructor(props){
    super(props);
    this.state = {}
  }

  render() {
    return (
      <Paper className={this.props.classes.root}>
        <Table className={this.props.classes.table} >
          <TableHead>
            <TableRow>
              <TableCell align="left">Track</TableCell>
              <TableCell>Artist</TableCell>
              <TableCell>Duration</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {this.props.tracks.map(track => (
              <TableRow key={track.id}>
                <TableCell align="left" component="th" scope="row">
                  {track.name}
                </TableCell>
                <TableCell>{track.artist_name}</TableCell>
                <TableCell>{track.duration}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </Paper>
    )
  }
}

export default withStyles(styles)(TracksList);