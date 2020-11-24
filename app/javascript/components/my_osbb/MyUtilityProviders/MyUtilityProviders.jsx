import React from "react"
import PropTypes from "prop-types"
import Moment from 'moment'
import NumberFormat from 'react-number-format';
import styles from './MyUtilityProviders.module.scss'

class MyUtilityProviders extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      balance: []
    };
  }

  componentDidMount() {
    fetch('/api/v1/balance.json')
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ balance: data }) });
  }
  
  render () {
    return (
      <div className={styles.items}>
        <div className={styles.title}>
          My Utility Providers Information:
        </div>
        <div className={styles.item}>
          Last payment:
        </div>
        <div className={styles.item}>
          { Moment(this.state.balance.last_payment_date).format('DD.MM.YYYY') }
        </div>
        <div className={styles.item}>
          Total payment:
        </div>
        <div className={styles.item}>
          <span className={ this.state.balance.balance_total < 0 ? styles.red : styles.green}>
            <NumberFormat value={this.state.balance.balance_total} displayType={'text'} decimalScale='2'/>
          </span>
        </div>
      </div>
    );
  }
}

export default MyUtilityProviders
