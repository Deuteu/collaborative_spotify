import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom'
import { withStyles } from '@material-ui/core/styles';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';


const styles = {
  root: {
    width: '100%',
    maxWidth: 360,
    minWidth: 200
  },
  item: {
    'text-decoration': 'none',
    color: 'inherit'
  }
};

class Playlists extends Component {
  static propTypes = {
    classes: PropTypes.object.isRequired,
    playlists: PropTypes.array,
    loadPlaylists: PropTypes.func
  };

  constructor(props){
    super(props);
  }

  componentDidMount() {
    if (!this.props.playlists) {
      this.props.loadPlaylists()
    }
  }

  get playlists() {
    return this.props.playlists || []
  }

  render() {
    const { classes } = this.props;

    return (
      <div className={classes.root}>
        <List component="nav">
          {this.playlists.map(playlist => (
            <ListItem button component={Link} to={`/playlists/${playlist.id}`} key={playlist.id}>
              <ListItemText primary={playlist.name} />
            </ListItem>
          ))}
        </List>
      </div>
    )
  }
}

export default withStyles(styles)(Playlists);