import React, { Component } from 'react';
import './App.css';
import PlaylistsContainer from './components/PlaylistsContainer';

class App extends Component {
    render() {
        return (
            <div className="app">
                <header className="app-header">
                    <h1 className="app-title">Hello !</h1>
                </header>
                <div className="app-body">
                    <PlaylistsContainer />
                </div>
            </div>
        );
    }
}

export default App;
