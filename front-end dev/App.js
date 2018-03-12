import React, { Component } from 'react';
import ReactDOM from 'react-dom'
import Select from 'react-select';

import 'react-select/dist/react-select.css';
import './App.css';

import defVals from './defaultValues';
import methodRequests from './methodFactory';

class App extends Component {  
  constructor() {
    super();
    this.state = { selectedOption       : 'login',
                   selectedOptionValues : defVals['login'],
                   response             : '',
                   loading              : false };
  }

  handleChange = (selectedOption) => {
    this.setState({ selectedOption });
    this.setState({ selectedOptionValues: defVals[selectedOption.value] });
    
  }

  updateBody = (event) => {
    this.setState({ selectedOptionValues: {
                                            url   : this.state.selectedOptionValues.url,
                                            method: this.state.selectedOptionValues.method,
                                            body  : event.target.value} });
  }

  updateResponseState = (response) => {
    this.setState({response});
  }

  toggleLoadingState = () => {
    this.setState({loading: !this.state.loading});
  }

  sendRequest = () => {
    methodRequests[this.state.selectedOptionValues.method](this.state.selectedOptionValues.url,
                                                           this.updateResponseState,
                                                           this.toggleLoadingState,
                                                           this.state.selectedOptionValues.body)
  }

  render() {
    const { selectedOption } = this.state;
    const value = selectedOption && selectedOption.value;

    return (
      <div className="container">
        <Select
          name="form-field-name"
          value={value}
          onChange={this.handleChange}
          options={[
            { value: 'login',      label: 'Login' },
            { value: 'register',   label: 'Register' },
            { value: 'addUsers',   label: 'Add Users' },
            { value: 'getUsers',   label: 'Get Users' },
            { value: 'getJobs',    label: 'Get Jobs' },
            { value: 'updateJobs', label: 'Update Jobs' },
          ]}
        />
        <p>Body:</p>
        <textarea onChange={this.updateBody} value={this.state.selectedOptionValues.body}/>
        <button onClick={this.sendRequest} disabled={this.state.loading}>Submit</button>
        {
          this.state.loading
          ? <p>Loading...</p>
          : <p>Response:</p>
        }
        <textarea disabled value={this.state.response}/>
      </div>
    );
  }
}

export default App;
