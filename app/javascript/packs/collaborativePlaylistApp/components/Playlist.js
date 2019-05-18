import React, { Component } from 'react';
import PropTypes from 'prop-types';
import TracksList from './TracksList';

class Playlist extends Component {
  static propTypes = {
    id: PropTypes.string.isRequired,
    tracks: PropTypes.array,
    loadTracks: PropTypes.func.isRequired
  };

  constructor(props){
    super(props);
  }

  componentDidMount() {
    if (!this.props.tracks) {
      this.props.loadTracks()
    }
  }

  get tracks() {
    return this.props.tracks || []
  }

  render() {
    return (
      <TracksList tracks={this.tracks} />
    )
  }
}

export default Playlist;