import React from "react"
import PropTypes from "prop-types"
import Tabs from "./Tabs";

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
      fetch(`/api/v1/account/admin/osbbs/` +this.props.id+ `.json`)
        .then((response) => {
          return response.json()
        })
        .then((data) => {
          this.setState({
            osbb: data['osbb']
          })
        });
    }

    mapImg = () => {
      let src = `https://maps.googleapis.com/maps/api/staticmap?zoom=17&size=500x300&markers=size:small%7Ccolor:red%7C${this.state.osbb.address.coordinates[0]},${this.state.osbb.address.coordinates[1]}&key=AIzaSyB79BaHbHY_1floWCNQ1nlSx78zj6CYG04`
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
        <div>
          <div className="title-content">
            <div className="d-flex align-items-center">
              <span><a className="fas-custom" href="/en/account/admin/osbbs"><i className="fas fa-arrow-left fa-lg"></i></a></span>
            </div>
            <h1 className="title title-osbb">OSBB info</h1>
            <div className="d-flex justify-content-around flex-wrap align-items-center">
              <span><a className="fas-custom" href={'/en/account/admin/osbbs/'+this.state.osbb.id+'/edit'}><i id="edit" className="fas fa-edit fa-lg"></i></a></span>
              <span><a className="fas-custom" data-confirm="Are you sure?" rel="nofollow" data-method="delete" href={'/en/account/admin/osbbs/'+this.state.osbb.id+'/'}><i id="delete" className="fas fa-trash-alt fa-lg"></i></a></span>
            </div>
          </div>
          <div className="osbb-info">
            <div className="osbb-content">
              <span className="item-name">OSBB Name: </span>
              <span className="item-value">{this.state.osbb.name}</span>
            </div>
            <div className="osbb-content">
              <span className="item-name">Phone number: </span>
              <span className="item-value">{this.state.osbb.phone}</span>
            </div>
            <div className="osbb-content">
              <span className="item-name">Email: </span>
              <span className="item-value">{this.state.osbb.email}</span>
            </div>
            <div className="osbb-content">
              <span className="item-name">OSBB Website: </span>
              <span className="item-value">{this.state.osbb.website}</span>
            </div>
          </div>
          <Tabs>
            <div label="Address">
              <ReturnAddress full_address={this.state.osbb.address.full_address} map={this.mapImg}/>
              <hr/>
            </div>
            <div label="Bank details">
              <div className="osbb-info">
                <ReturnAccount edrpou={this.state.osbb.account.edrpou} iban={this.state.osbb.account.iban}/>
              </div>
              <hr/>
            </div>
          </Tabs>
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
      <div key="iban" className="osbb-content">
        <span className="item-name">Iban: </span>
        <span className="item-value">{account.iban}</span>
      </div>,
      <div key="edrpou" className="osbb-content">
        <span className="item-name">Edrpou: </span>
        <span className="item-value">{account.edrpou}</span>
      </div>
    ]
  }
  else return null;
}


function ReturnAddress(address) {
  if (address) {
    return (
      <div className="osbb-content">
        <div className="content-center">
          <span className="item-value">{address.full_address}</span>
        </div>
        <div className="map-osbb">{address.map()}</div>
      </div>
    )
  }
  else return null;
}


export default ShowOsbb
