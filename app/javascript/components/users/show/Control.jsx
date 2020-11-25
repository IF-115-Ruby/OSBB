import React, { Component } from 'react';
import axios from 'axios';

export class UserShowControl extends Component {

  constructor(props) {
    super(props)
    this.handleDelete = this.handleDelete.bind(this)
  };

  goBack() {
    window.history.back();
  };

  handleDelete() {
    const token = document.querySelector('[name=csrf-token]').content
    axios.defaults.headers.common['X-CSRF-TOKEN'] = token
    axios.delete('../admin/users/' + this.props.user.id)
      .then(() => {
        window.location.href = '../admin/users/'
      })
      .catch((error) => {
        alert(error);
      });
    };

  render() {
    return (
      <nav>
        <ul className='nav navbar-user show-box'>
          <li className='nav-item-user'>
            <button className='btn btn-danger' onClick={this.handleDelete}>Delete</button>
          </li>
          <li className='nav-item-user'>
            <button className='btn btn-info' onClick={this.goBack}>Back</button>
          </li>
        </ul>
      </nav>
    );
  };
};
