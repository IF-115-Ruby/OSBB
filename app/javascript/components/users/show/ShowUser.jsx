import React, { Component } from 'react';
import { UserShowControl } from './Control';
import { InfoHelper } from './_InfoHelper';

class ShowUser extends Component {
  constructor(props) {
    super(props);
    this.state = {
      user: []
    };
  };

  componentDidMount(){
    const id = window.location.pathname.split('/')
    fetch('/api/v1/users/' + id[id.length - 1] + '.json')
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ user: data }) });
  };

  render() {
    return(
      <div className='form-component'>
        <h1 className='title'>User info:</h1>
        <div className='show-box'>
          <div className='user-avatar-show'>
            <img src={ this.state.user.show_avatar } alt='Image' className='user-avatar'></img>
          </div>
          <div className='user-info'>
            <InfoHelper name='Username:' value={ this.state.user.full_name } />
            <hr className='user-item-hr'/>
            <InfoHelper name='Date of Birthday:' value={ this.state.user.birthday } />
            <hr className='user-item-hr'/>
            <InfoHelper name='Email:' value={ this.state.user.email } />
            <hr className='user-item-hr'/>
            <InfoHelper name='Phone:' value={ this.state.user.mobile } />
            <hr className='user-item-hr'/>
            <InfoHelper name='Sex:' value={ this.state.user.sex } />
            <hr className='user-item-hr'/>
            <InfoHelper name='Role:' value={ this.state.user.role } />
          </div>
        </div>
        < UserShowControl user = { this.state.user }/>
      </div>
    );
  };
};

export default ShowUser;
