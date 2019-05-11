import React, { Component } from 'react';
import axios from 'axios';

class PlaylistsContainer extends Component {
    constructor(props){
        super(props);
        this.state = {
            playlists: []
        }
    }

    componentDidMount() {
        axios.get('api/playlists')
            .then(response => {
                console.log(response);
                this.setState({
                  playlists: response.data
                })
            })
            .catch(error => console.log(error))
    }

    render() {
        return (
            <div className="playlists-container">
                {this.state.playlists.map( playlist => {
                    return (
                        <div className="playlist" key={playlist.id} data-id={playlist.id}>
                            <p>{playlist.name}</p>
                        </div>
                    )
                })}
            </div>
        )
    }
}

export default PlaylistsContainer;