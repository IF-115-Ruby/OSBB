import React from 'react'
import styles from './ShowItem.module.scss'
import Moment from 'moment'
import { Icon } from 'semantic-ui-react'
import { Link } from 'react-router-dom'
import axios from 'axios'

const ShowItem = (props)=> {
  const { title, image, long_description, created_at, is_visible} = props.data
  const longDescription = () => { return { __html: long_description } }
  const not_visible = () => { if (!is_visible) return <span><i className="fas fa-eye-slash fa-lg"></i></span> }
  const handleDelete = ()=> {
    axios.defaults.headers.common['X-CSRF-TOKEN'] = document.querySelector('[name=csrf-token]').content
    axios.delete(`/api/v1/posts/${props.data.id}`)
      .then(window.location.href = '../posts').catch((error) => console.log(error.message));
    };

  return (
    <div className={styles.postBlock}>
      <div className={styles.middleContainer}>
        {not_visible()}
        <h5>Posted at {Moment(created_at).format('MMMM Do YYYY, hh:mm:ss')}</h5>
        <div className={styles.controlButtons}>
          <Link to={{pathname: `/en/account/posts/${props.data.id}/edit`, post: props.data}}>
            <Icon title='Edit Post' name='edit outline' />
          </Link>
          <Link className='ml-2 mr-2' to='!#' onClick={handleDelete}>
            <Icon title='Delete Post' name='trash alternate outline'/>
          </Link>
          <Link to='/en/account/posts'>
            <Icon title='Back' name='step backward' />
          </Link>
        </div>
      </div>
      <img src={image.url} alt={title} />
      <div>
        <h2 className={styles.postTitle}>{title}</h2>
        <p className={styles.longDescription} dangerouslySetInnerHTML={longDescription()}/>
      </div>
    </div>
  )
}

export default ShowItem
