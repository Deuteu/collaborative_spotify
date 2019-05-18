import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from 'react-router-dom'
import Client from './Client';
import AppBar from './components/AppBar';
import Drawer from './components/Drawer';
import Playlists from './components/Playlists';
import Playlist from './components/Playlist';


class App extends Component {
  constructor(props){
    super(props);
    this.state = {
      drawerOpened: false,
      playlists: null,
      tracks: {}
    }
  }

  toggleDrawer = (open) => {
    return () => {
      this.setState({drawerOpened: !!open})
    }
  };

  loadPlaylists = () => {
    return () => {
      Client.playlists()
        .then(data => {
          this.setState({playlists: data});
        })
    }
  };

  loadPlaylistTracksFor = (id) => {
    return () => {
      Client.playlistTracks(id)
        .then(data => {
          const tracks = this.state.tracks;
          tracks[id] = data;
          this.setState({tracks: tracks});
        })
    }
  };

  componentDidMount() {
    this.loadPlaylists()
  }

  render() {
    return (
      <Router>
        <AppBar onMenuClicked={this.toggleDrawer(true)}/>
        <Drawer open={this.state.drawerOpened}
                onClose={this.toggleDrawer(false)}
                content={<Playlists playlists={this.state.playlists}
                                    loadPlaylists={this.loadPlaylists()}/>}
        />
        <div>
          <Switch>
            <Route exact path='/' render={() => {}} />
            <Route exact path="/playlists/:playlistId" render={({ match }) => {
              const id = match.params.playlistId;
              return (
                <Playlist id={id}
                          tracks={this.state.tracks[id]}
                          loadTracks={this.loadPlaylistTracksFor(id)}
                />
              )
            }} />
          </Switch>
        </div>
      </Router>
    )
  }
}

export default App;