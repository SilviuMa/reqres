import axios from 'axios';

const methodRequests = {
    GET: function(url, updateState, toggleLoadingState) {
        toggleLoadingState();
        axios.get(url)
        .then(function (response) {
            updateState(JSON.stringify(JSON.parse(response.data.body),null,2));
            toggleLoadingState();
        })
        .catch(function (error) {
            updateState(error);
            toggleLoadingState();
        });
    },
    POST: function(url, updateState, toggleLoadingState, body) {
        toggleLoadingState();
        axios.post(url, body)
          .then(function (response) {
            updateState(JSON.stringify(JSON.parse(response.data.body),null,2));
            toggleLoadingState();
          })
          .catch(function (error) {
            updateState(error);
            toggleLoadingState();
          });
    },
    POSTarrayBody: function(url, updateState, toggleLoadingState, body) {
        toggleLoadingState();
        axios.post(url, body)
          .then(function (response) {
            updateState(response.data);
            toggleLoadingState();
          })
          .catch(function (error) {
            updateState(error);
            toggleLoadingState();
          });
    },
    PUT: function(url, updateState, toggleLoadingState, body) {
        toggleLoadingState();
        axios.put(url, body)
        .then(function (response) {
            updateState(JSON.stringify(JSON.parse(response.data.body),null,2));
            toggleLoadingState();
        })
        .catch(function (error) {
            updateState(error);
            toggleLoadingState();
        });
    },
    PUTarrayBody: function(url, updateState, toggleLoadingState, body) {
        toggleLoadingState();
        axios.put(url, body)
          .then(function (response) {
            updateState(response.data);
            toggleLoadingState();
          })
          .catch(function (error) {
            updateState(error);
            toggleLoadingState();
          });
    }
}

export default methodRequests;
