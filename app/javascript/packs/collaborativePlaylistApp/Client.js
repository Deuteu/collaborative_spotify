function catchError(response) {
  if (response.status >= 200 && response.status < 300) {
    return response;
  }
  const error = new Error(`HTTP Error ${response.statusText}`);
  error.status = response.statusText;
  error.response = response;
  throw error;
}

function parseJSON(response) {
  return response.json();
}

function wrap(call) {
  return call
    .then(catchError)
    .then(parseJSON)
}

function playlists() {
  return wrap(fetch(`/api/playlists`))
}

function playlistTracks(id) {
  return wrap(fetch(`/api/playlists/${id}/tracks`))
}

const Client = { playlists, playlistTracks };
export default Client;