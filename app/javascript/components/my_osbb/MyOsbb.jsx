import React from "react"
import PropTypes from "prop-types"
import { Route, BrowserRouter } from 'react-router-dom'
import styles from './MyOsbb.module.scss'
import MyUtilityProviders from './MyUtilityProviders/MyUtilityProviders'
import Menu from './Menu/Menu'
import News from './News/News'
import Neighbors from '../neighbors/Index'

const MyOsbb = (props) => {
    return (
      <BrowserRouter>
        <div className={styles.myosbb}>
          <div className={styles.navbar}>
            <div className={styles.container}>
              <MyUtilityProviders />
            </div>
            <div className={styles.container}>
              <Menu />
            </div>
          </div>
          <Route path='/:locale/account/myosbb/' render={ () => <News />}/>
          <Route path='/:locale/account/neighbors/' render={() => <Neighbors />}/>
        </div>
      </BrowserRouter>
    );
}

export default MyOsbb
