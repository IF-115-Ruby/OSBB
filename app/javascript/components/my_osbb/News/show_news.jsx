import React from 'react';
import PropTypes from "prop-types"

class ShowNews extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      news: []
    };
  }

  componentDidMount() {
    console.log(this.props);
    fetch('/api/v1/news/4')
      .then((response) => { return response.json() })
      .then((data) => { this.setState({ news: data }) });
  }

   render() {
    return (
      <div>
        <h3>Title: {this.state.news.title} </h3>
      </div>
    )
  }
}

export default ShowNews
