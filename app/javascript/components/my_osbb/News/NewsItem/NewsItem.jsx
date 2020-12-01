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
  
    goBack() {
      window.location.href = '../account/myosbb'
    };
  
    handleDelete() {
      const token = document.querySelector('[name=csrf-token]').content
      axios.defaults.headers.common['X-CSRF-TOKEN'] = token
      axios.delete('../api/v1/news/' + this.props.attributes.id)
        .then(window.location.href = `../account/myosbb`)
        .catch((error) => {
          console.log(error.message)
        });
      };
  render () {
    return (
      <div className={styles.lightContainer}>
        <h1 className={styles.title}>
          <a href={`/account/news/${this.props.attributes.id}`}>{this.props.attributes.title}</a>
        </h1>
        <p>{this.props.attributes.short_description}</p>
        <button onClick={this.handleDelete} className = "btn btn-warning" id = "button-width-120">Delete</button>
        <a rel="New post" href={`/account/news/${this.props.attributes.id}/edit`} className = "btn btn-danger float-right" id = "button-width-120">Edit</a>
      </div>
    );
  }
}

export default NewsItem

