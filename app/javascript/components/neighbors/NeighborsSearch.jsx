import React from "react"
import PropTypes from "prop-types"

class NeighborsSearch extends React.Component {
  render() {
    return (
      <div className="user-search m-auto">
        <p>Search neighbors: </p>
        <form ref="form" action={this.props.searchPath} acceptCharset="UTF-8" method="get">
          <select className="select-css" ref="query" name="query" onChange={this.props.submitPath}>
            <option value="">All</option>
            <option value="true">Approved</option>
            <option value="false">Non-approved</option>
          </select>
        </form>
      </div>
    );
  }
}

export default NeighborsSearch
