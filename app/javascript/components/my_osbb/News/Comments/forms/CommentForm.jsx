import React, { useState } from 'react';
import { Comment, Avatar } from 'antd';
import 'antd/dist/antd.css';
import axios from 'axios';
import { Editor } from './Editor';

export const CommentForm = ({ current_user, news_id, addToState }) => {
  const [value, setValue] = useState('')
  const [load, setLoad] = useState(false)

  const addComment = (comment_id) => {
    addToState({
      'body': value,
      'id': comment_id,
      'time': 'less than a minute ago ',
      'user_avatar': current_user.avatar,
      'user_full_name': current_user.full_name,
    });
  }

  const handleChange = e => {
    setValue(e.target.value)
  };

  const handleSubmit = () => {
    if (!value) {
      return;
    }
    setLoad(true);
    let formData = new FormData();
    formData.append('body', value);

    const token = document.querySelector('[name=csrf-token]').content;
    axios.defaults.headers.common['X-CSRF-TOKEN'] = token;

    axios({
      method: 'post',
      url: '/api/v1/news/' + news_id + '/comments',
      data: formData,
      headers: {'Content-Type': 'multipart/form-data' }
      })
      .then((response) => {
        console.log(response);
        addComment(response.data.id);
      })
      .catch((response) => {
          console.log(response);
      });

    setTimeout(() => {
      setValue('');
      setLoad(false);
    }, 1000);
  };

  return (
    <Comment
      avatar={
        <Avatar
          src= { current_user.avatar }
          alt= { current_user.full_name }
        />
      }
      content={
        <Editor
          onChange={ handleChange }
          onSubmit={ handleSubmit }
          submitting={ load }
          value={ value }
        />
      }
    />
  );
}
