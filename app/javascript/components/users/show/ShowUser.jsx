import React, { Component } from 'react';
import { UserShowControl } from './Control';
import { InfoHelper } from './_InfoHelper';
import AOS from 'aos';
import 'aos/dist/aos.css';

AOS.init();
class ShowUser extends Component {
  constructor(props) {
    super(props);
    this.state = {
      user: {
        osbb: [],
        address: [],
      }
    };
    this.osbbInfo = this.osbbInfo.bind(this)
    this.addressInfo = this.addressInfo.bind(this)
  };

  componentDidMount(){
    fetch('/api/v1/users/' + this.props.id + '.json')
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ user: data }) });
  };

  addressInfo(address){
    const { country, state, city, street } = address

    const info = {
      'Country:': country,
      'State:': state,
      'City:': city,
      'Street:': street,
    }

    return(
      <>
      <h1>Address info:</h1>
      {Object.keys(info).map( key => {
        return <InfoHelper key={key} name={key} value={ info[key] } />
      })}
      </>
    )
  }

  osbbInfo(osbb) {
      if (osbb.role) {
        return(
          <InfoHelper name='Osbb:'
                      value={`${osbb.role} of `}
                      link={<a href={'../admin/osbbs/' + osbb.id}>"{osbb.name}"</a>} />
        )
      }else{
        return <InfoHelper name='Osbb:' value='Not in OSBB Group' />
      }
  };

  render() {
    const { address, birthday, email, full_name, id,
            mobile, osbb, role, sex, show_avatar
          } = this.state.user
    const userInfo = {
      'Username:': full_name,
      'Date of Birthday:': birthday,
      'Email:': email,
      'Phone:': mobile,
      'Sex:': sex,
    }
    return(
      <div data-aos="flip-left"
           data-aos-duration="1500"
           className='form-component position-relative'
      >
        <div className='user-avatar-show'>
          <img src={ show_avatar } alt='Image' className='user-avatar'/>
        </div>
        <h1 data-aos="fade-up"
            data-aos-delay="1400"
            className='title'>User info:
        </h1>
        <div className='show-box'>
          <div data-aos="fade-up"
               data-aos-delay="1800"
               data-aos-offset="0"
               data-aos-duration="1500"
               className='user-info'
          >
            { Object.keys(userInfo).map(key => {
              return <InfoHelper key={key} name={key} value={ userInfo[key] }/>
            })}
            { this.addressInfo(address) }
            <h1>Osbb cite info:</h1>
            <InfoHelper name='Role:' value={ role } />
            { this.osbbInfo(osbb) }
          </div>
        </div>
        <UserShowControl id={ id } osbb_id={ osbb.id }/>
      </div>
    );
  };
}

export default ShowUser;
