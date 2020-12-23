import React from "react"
import PropTypes from "prop-types"
import { NavLink } from "react-router-dom"
import styles from './Menu.module.scss'

class Menu extends React.Component {
  render () {
    return (
      <div className={styles.tab}>
          <NavLink className={styles.tablinks} to='/en/account/myosbb/' activeClassName={styles.activeLink} >News</NavLink>
          <NavLink className={styles.tablinks} to='/en/account/posts/' activeClassName={styles.activeLink} >Posts</NavLink>
          <NavLink className={styles.tablinks} to='/en/account/neighbors/'  activeClassName={styles.activeLink}>Neighbors</NavLink>
          <NavLink className={styles.tablinks} to={'/en/account/ossb/' +this.props.osbb_id} activeClassName={styles.activeLink}>OSBB Info Page</NavLink>
      </div>
    );
  }
}

export default Menu
