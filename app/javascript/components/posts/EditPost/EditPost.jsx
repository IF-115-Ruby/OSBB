import React, { useState, useEffect } from 'react'
import PostsForm from '../PostsForm'
import axios from 'axios'
import styles from '../CreatePost/CreatePost.module.scss'

const EditPost = (props)=> {
  const [post] = useState(()=> {
    const storagePost = window.localStorage.getItem('post')
    const defaultValue = props.location.post
    return defaultValue === undefined ? JSON.parse(storagePost) : defaultValue
  })
  
  useEffect(()=> { if (props.location.post) localStorage.setItem('post', JSON.stringify(props.location.post)) }, [])
  const handleSubmit = (values, long_description, image)=> { const formData = new FormData();
    for ( var key in values ) { formData.append(key, values[key]) }
    formData.append('long_description', long_description);
    if (image) formData.append('image', image) ;
    axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('[name="csrf-token"]').content;
    axios.put(`/api/v1/posts/${props.match.params.id}`, formData).then( resp => {
        if (resp.status == 200) { return resp }
        throw new Error("Network response was not ok.");
      }).then(resp => window.location.href = '../../posts').catch( resp => console.log(resp.message))
  }
  return (
    <div className={styles.createFormWrapper}>
      <h2 className='text-center mt-4'>Edit Post</h2>
      <PostsForm handleSubmit = {handleSubmit} post = {post} />
    </div>
  )
}

export default EditPost
