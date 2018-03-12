import axios from 'axios';

const methodRequests = {
    GET: function(url, updateState) {
        axios.get(url)
        .then(function (response) {
            updateState(JSON.stringify(JSON.parse(response.data.body),null,2));
        })
        .catch(function (error) {
            updateState(error);
        });
    },
    POST: function(url, updateState, body) {
        axios.post(url, body)
          .then(function (response) {
            updateState(JSON.stringify(JSON.parse(response.data.body),null,2));
          })
          .catch(function (error) {
            updateState(error);
          });
    },
    PUT: function(url, updateState, body) {
        axios.put(url, body)
        .then(function (response) {
            updateState(JSON.stringify(JSON.parse(response.data.body),null,2));
        })
        .catch(function (error) {
            updateState(error);
        });
    }
}

export default methodRequests;