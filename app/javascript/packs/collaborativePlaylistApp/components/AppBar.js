import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom'
import { withStyles } from '@material-ui/core/styles';
import AppBar from "@material-ui/core/AppBar/AppBar";
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';
import Toolbar from "@material-ui/core/Toolbar/Toolbar";
import Typography from '@material-ui/core/Typography';

const styles = {
  root: {
    flexGrow: 1,
  },
  grow: {
    flexGrow: 1,
  },
  menuButton: {
    marginLeft: -12,
    marginRight: 20,
  },
  home: {
    'text-decoration': 'none',
    color: 'inherit'
  }
};

class MyAppBar extends Component {
  static propTypes = {
    classes: PropTypes.object.isRequired,
    onMenuClicked: PropTypes.func.isRequired,
    homePath: PropTypes.string
  };

  static defaultProps = {
    homePath: '/',
  };

  constructor(props) {
    super(props);
  }

  render() {
    const { classes } = this.props;

    return (
      <AppBar position="static">
        <Toolbar>
          <IconButton className={classes.menuButton} color="inherit" aria-label="Menu" onClick={this.props.onMenuClicked}>
            <MenuIcon />

          </IconButton>
          <Typography variant="h6" color="inherit" className={classes.grow}>
            <Link to={this.props.homePath} className={classes.home}>My App</Link>
          </Typography>
        </Toolbar>
      </AppBar>
    )
  }
}

export default withStyles(styles)(MyAppBar)