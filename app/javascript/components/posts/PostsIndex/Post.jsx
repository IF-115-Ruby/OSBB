import React from 'react'
import styles from './Post.module.scss'
import { Link } from 'react-router-dom'

const Post = (props) => {
  return (
    <div className={styles.lightContainer}>
      <div className={styles.postSubBox}>
        <h1 className={styles.titlePost}>
          <Link to={`/en/account/posts/${props.data.id}`}>{props.data.title}</Link>
        </h1>
        <p>{props.data.short_description}</p>
      </div>
      <img className={styles.subBoxImg} src={props.data.image.url} alt={props.data.title} />
    </div>
  );
}

export default Post
