import React from "react"
import AllNeighbors from "./AllNeighbors"
import NeighborSearch from "./NeighborsSearch"

class Index extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      data: [],
      searchPath: "/api/v1/neighbors/search"
    };
    this.searchNeighbors = this.searchNeighbors.bind(this);
    this.fetchNeighbors = this.fetchNeighbors.bind(this);
  }

  componentDidMount() {
    this.fetchNeighbors();
  }

  fetchNeighbors() {
    $.ajax({
      url: "/api/v1/neighbors",
      dataType: 'json',
      success: function (data) {
        this.setState({ data: data });
      }.bind(this),
      error: function (data) {
        this.setState({ data: [] });
      }.bind(this)
    });
  }

  searchNeighbors(event) {
    if (event.target.value) {
      $.ajax({
        url: "/api/v1/neighbors/search?approved=" + event.target.value,
        dataType: 'json',
        success: function (data) {
          this.setState({ data: data });
        }.bind(this),
        error: function () {
          this.setState({ data: [] });
        }.bind(this)
      });
    }
    else {
      this.fetchNeighbors();
    }
  }

  getInitialState() {
    return { data: [] };
  }

  render() {
    return (
      <div className="container-wrapper-neighbors">
        <h1 key="Neighbors">Neighbors</h1>
        <NeighborSearch searchPath={this.state.searchPath} submitPath={this.searchNeighbors} cancelPath={this.fetchNeighbors} />
        <div key="AllNeighbors" className="neighbor-index">
          <AllNeighbors neighbors={this.state.data.neighbors} current_user={this.state.data.user}/>
        </div>
      </div>
    );

  }
}

export default Index
