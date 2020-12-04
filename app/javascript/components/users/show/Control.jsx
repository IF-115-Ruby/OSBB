import React, { Component } from 'react';
import axios from 'axios';
import PropTypes from 'prop-types';
import SvgIconReturn from '../../../../assets/images/svg_icon_return.svg';
import SvgIconDelete from '../../../../assets/images/svg_icon_delete.svg';

export class UserShowControl extends Component {

  constructor(props) {
    super(props)
    this.handleDelete = this.handleDelete.bind(this);
  };

  goBack() {
    window.location.href = '../admin/users/'
  };

  handleDelete() {
    const token = document.querySelector('[name=csrf-token]').content
    axios.defaults.headers.common['X-CSRF-TOKEN'] = token
    axios.delete('../admin/users/' + this.props.id)
      .then(() => {
        this.goBack()
      })
      .catch((error) => {
        alert(error);
      });
    };

  render() {
    return (
      <nav>
        <ul className='nav navbar-user show-box'>
            <ButtonsComponent svg={SvgIconDelete}
                              event={ this.handleDelete }
                              style='btn show-user-btn right-btn'
            />
            <ButtonsComponent svg={ SvgIconReturn }
                              event={ this.goBack }
                              style='btn show-user-btn left-btn'
            />
        </ul>
      </nav>
    );
  };
}

const ButtonsComponent = ({ event, style, svg }) => {
  return (
    <li className='nav-item-user'>
      <button className={ style } onClick={ event }><img src={ svg }/></button>
    </li>
  );
}

ButtonsComponent.propTypes = {
  event: PropTypes.func,
  style: PropTypes.string,
}
