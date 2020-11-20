import React from "react"
import NeighborItem from "./NeighborItem"

class AllNeighbors extends React.Component {
  render() {
    if (this.props.neighbors) {
      var neighbors = this.props.neighbors.map((neighbor) => {
        return (
          <NeighborItem neighbor={neighbor} current_user={this.props.current_user} key={neighbor.id} />
        )
      })
    }
    return (
      <div className="row">
        {neighbors}
      </div>
    )
  }
}

export default AllNeighbors
