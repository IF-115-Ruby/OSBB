import React from 'react'
import styles from './CreatePost.module.scss'
import axios from 'axios'
import PostsForm from '../PostsForm'

const CreatePost = () => {
  const handleSubmit = (values, long_description, image)=> {
    const formData = new FormData();
    for ( var key in values ) { formData.append(key, values[key]) }
    formData.append('long_description', long_description)
    if (image) formData.append('image', image);
    axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('[name="csrf-token"]').content;
    axios.post('/api/v1/posts', formData)
      .then( resp => {
        if (resp.status == 201) {return resp}
        throw new Error("Network response was not ok.");
      })
      .then(resp => window.location.href = '../posts').catch( resp => console.log(resp.message))
  }
  
  return (
    <div className={styles.createFormWrapper}>
      <h2 className='text-center mt-4'>Add new Post</h2>
      <PostsForm handleSubmit = {handleSubmit}
        post = {{title: "", short_description: "", long_description: "", is_visible: ""}} />
    </div>
  )
}

export default CreatePost
