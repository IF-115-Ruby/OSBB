import React, { Fragment } from 'react'
import PropTypes from "prop-types"
import { Link } from 'react-router-dom'
import styles from './NewsItem.module.scss'
import axios from 'axios';


class NewsItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleDelete = this.handleDelete.bind(this);
  }
  
    handleDelete() {
      const token = document.querySelector('[name=csrf-token]').content
      axios.defaults.headers.common['X-CSRF-TOKEN'] = token
      axios.delete('/account/news/' + this.props.attributes.id)
        .then(window.location.href = `../../account/myosbb`)
        .catch((error) => {
          console.log(error.message)
        });
      };
  render () {
    const { id, title, short_description } = this.props.attributes

    return (
      <div className={styles.lightContainer}>
        <h1 className={styles.title}>
          <a href={`/account/news/${id}`}>{title}</a>
        </h1>
        <p>{short_description}</p>
        <button onClick={this.handleDelete} className = "btn btn-warning" id = "button-width-120">Delete</button>
        <a rel="New post" href={`/account/news/${this.props.attributes.id}/edit`} className = "btn btn-danger float-right" id = "button-width-120">Edit</a>
      </div>
    );
  }
}

export default NewsItem

