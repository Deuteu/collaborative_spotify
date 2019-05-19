import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Drawer from "@material-ui/core/Drawer";

class MyDrawer extends Component {
  static propTypes = {
    onClose: PropTypes.func.isRequired
  };

  render () {
    return (
      <Drawer open={this.props.open} onClose={this.props.onClose}>
        <div
          tabIndex={0}
          role="button"
          onClick={this.props.onClose}
          onKeyDown={this.props.onClose}
        >
          {this.props.content}
        </div>
      </Drawer>
    )
  }
}

export default MyDrawer;