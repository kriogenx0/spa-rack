import React from 'react';
import ReactDOM from 'react-dom';

class App extends React.Component {

  constructor(p, c) {
    super(p, c);
    this.state = {
      status: null
    };

    this.handleButtonClick = this.handleButtonClick.bind(this);
    this.apiCallback = this.apiCallback.bind(this);
  }

  handleButtonClick() {
    this.setState({ status: 'Requesting from API' });
    this.xhr = new XMLHttpRequest();
    this.xhr.open('GET', '/api/items?filter=some', true);
    this.xhr.onreadystatechange = this.apiCallback;
    this.xhr.send();
  }

  apiCallback() {
    if (this.xhr.readyState != 4) return;
    this.setState({ status: "API Responded: " + this.xhr.responseText });
  }

  render() {
    return (
      <div className='middle'>
        <img src='/assets/icon-ruby.png' height="100" />
        <h1>React is on Ruby Rack!</h1>

        <button onClick={this.handleButtonClick}>
          Do API Call
        </button>

        <h2>{this.state.status}</h2>

        <p className='info'>If you are seeing this page, Rack is serving React. The image above shows that you can load static assets. The API call shows you can use a Ruby API Proxy. Ruby API Proxies are common if you have a Ruby API Client that connects to webservices.</p>
      </div>
    );
  }
}

ReactDOM.render(<App />, document.getElementById('react'));
