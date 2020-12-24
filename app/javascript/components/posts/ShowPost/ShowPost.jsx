import React, { useState, useEffect } from 'react'
import axios from 'axios'
import ShowItem from './ShowItem'
import styles from './ShowPost.module.scss'

const ShowPost = (props) => {
  const [post, setPost] = useState([])
  const [loaded, setLoaded] = useState(false)

  useEffect(() => {
    const id = props.match.params.id
    const url = `/api/v1/posts/${id}`
    
    axios.get(url)
    .then( resp => {
      setPost(resp.data)
      setLoaded(true)
    })
    .catch( resp => console.log(resp))
  }, [])

  return (
    <div className={styles.postWrapper}>
      <div className={styles.post}>
        {loaded &&
        <ShowItem data={post} />}
      </div>
    </div>
  );
}

export default ShowPost
