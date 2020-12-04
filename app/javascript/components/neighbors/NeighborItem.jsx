import React from "react"
import avatar from "./../../../../public/default_a.png"
import PropTypes from "prop-types"

class NeighborItem extends React.Component {
  render () {
    let neighbor = this.props.neighbor;
    let current_user = this.props.current_user;
    return (
      <div className="col-md-4 neighbor-size-item">
        <div className="user-index-size layout-neighbor-content rounded">
          <div className="ml-30">
            <p>
              <Avatar url={neighbor.avatar_url} />
            </p>
          </div>
          <div className="user-hidden-block ml-30">
            <NeighborInfo full_name={neighbor.full_name} email={neighbor.email} />
            <div>
              <a className="btn btn-outline-primary" href={"/account/users/" + neighbor.id}>Show</a>
              <Approved id={neighbor.id} approved={neighbor.approved} role={current_user.role}/>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

function Avatar(neighbor) {
  if (neighbor.url) {
    return <img src={neighbor.url} alt="Image" className="user-avatar" ></img>
  } else {
    return <img src={avatar} alt="Image" className="user-avatar"></img>
  }
}

function NeighborInfo(neighbor) {
  return [
    <p key={neighbor.full_name} >Name: {neighbor.full_name}</p>,
    <p key={neighbor.email} >Email: {neighbor.email}</p>
  ]
}

function Approved(data) {
  let approved_reject_data = {
    osbb_id: null,
    approved: false,
    role: 'simple'
  };
  let approved_accept_data = {
    approved: true,
    role: 'member'
  };
  if (data.approved) return null;
  else if (data.role == "lead") {
    return [
      <a key="Accept" className="btn btn-outline-success ml-30 approved" onClick={() => updateRequest(data.id, approved_accept_data)}><i className="fas fa-check"></i></a>,
      <a key="Reject" className="btn btn-outline-danger approved" onClick={() => updateRequest(data.id, approved_reject_data)}><i className="fas fa-times"></i></a>
    ]
  }
  else return null;
}

function updateRequest(id, data) {
  fetch('/api/v1/neighbors/' + id, {
    method: 'put',
    body: JSON.stringify(data),
    headers: { 'Content-Type': 'application/json' },
  }).then(() => {
    location.href = document.location.pathname;
  });
}

export default NeighborItem
