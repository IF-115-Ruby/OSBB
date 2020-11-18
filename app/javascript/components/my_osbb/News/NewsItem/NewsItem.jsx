import React, { Fragment } from 'react'
import PropTypes from "prop-types"
import { Link } from 'react-router-dom'
import styles from './NewsItem.module.scss'

class NewsItem extends React.Component {
  render () {
    return (
      <div className={styles.lightContainer}>
        <h1 className={styles.title}>
          <a href={`/account/news/${this.props.attributes.id}`}>{this.props.attributes.title}</a>
        </h1>
        <p>{this.props.attributes.short_description}</p>
      </div>
    );
  }
}

export default NewsItem

