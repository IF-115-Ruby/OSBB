import React from "react"
import PropTypes from "prop-types"

class ShowOsbb extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        osbb: {
          address: {
            coordinates: []
          },
          account: {}
        }
      };
    }

    componentDidMount() {
      let path = document.location.pathname.split("/");
      let id = path[path.length - 1];
      fetch(`/api/v1/account/admin/osbbs/` + id + `.json`)
        .then((response) => {
          return response.json()
        })
        .then((data) => {
          this.setState({
            osbb: data['osbb']
          })
        });
    }


    map_img = () => {
      let src = `https://maps.googleapis.com/maps/api/staticmap?zoom=17&size=400x300&markers=size:small%7Ccolor:red%7C${this.state.osbb.address.coordinates[0]},${this.state.osbb.address.coordinates[1]}&key=AIzaSyB79BaHbHY_1floWCNQ1nlSx78zj6CYG04`
      return ( <
        img src = {
          src
        }
        alt = "Map" / >
      )
    }

  render () {
    AddStyleForParent();
    return (
      <div className="component-show">
        <h1 className="title">OSBB info: </h1>
        <div className="content-info">
          <div className="info-content">
            <span className="name">OSBB Name: </span>
            <span className="value">{this.state.osbb.name}</span>
          </div>
          <div className="info-content">
            <span className="name">Phone number: </span>
            <span className="value">{this.state.osbb.phone}</span>
          </div>
          <div className="info-content">
            <span className="name">Email: </span>
            <span className="value">{this.state.osbb.email}</span>
          </div>
          <div className="info-content">
            <span className="name">OSBB Website: </span>
            <span className="value">{this.state.osbb.website}</span>
          </div>
          <ReturnAccount edrpou={this.state.osbb.account.edrpou} iban={this.state.osbb.account.iban}/>
          <ReturnAddress full_address={this.state.osbb.address.full_address} map={this.map_img}/>
        </div>
        <hr/>
        <div className="d-flex justify-content-around flex-wrap">
          <span><a className="btn btn-warning btn-custom" href={'/en/account/admin/osbbs/'+this.state.osbb.id+'/edit'}>Edit osbb profile</a></span>
          <span><a data-confirm="Are you sure?" className="btn btn-danger btn-custom" rel="nofollow" data-method="delete" href={'/en/account/admin/osbbs/'+this.state.osbb.id+'/'}>Delete osbb</a></span>
          <span><a className="btn btn-info btn-custom" href="/en/account/admin/osbbs">Back to Osbbs</a></span>
        </div>
      </div>
    );
  }
}

function AddStyleForParent() {
  var el = document.getElementsByClassName("component-show")[0];
  if (el) {
    parent = el.parentNode;
    parent.className = "content pt-4";
  }
}

function ReturnAccount(account) {
  if (account) {
    return [
      <hr key="hr"/>,
      <div key="iban" className="info-content">
        <span className="name">OSBB iban: </span>
        <span className="value">{account.iban}</span>
      </div>,
      <div key="edrpou" className="info-content">
        <span className="name">OSBB edrpou: </span>
        <span className="value">{account.edrpou}</span>
      </div>
    ]
  }
  else return null;
}

function ReturnAddress(address) {
  if (address) {
    return (
      <div className="info-content">
        <hr/>
        <span className="name">Address: </span>
        <span className="value">{address.full_address}</span>
        <br/>
        <br/>
        <div className="map-box">{address.map()}</div>
      </div>
    )
  }
  else return null;
}



export default ShowOsbb
