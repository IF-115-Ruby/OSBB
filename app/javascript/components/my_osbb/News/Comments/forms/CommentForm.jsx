import React, { useState } from 'react';
import { Comment, Avatar } from 'antd';
import { Editor } from './Editor';
import { createComment } from '../requests';

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

    const url = '/api/v1/news/' + news_id + '/comments'
    createComment(url, undefined, {'Content-Type': 'multipart/form-data' }, value).then(res => {
    }).catch((err) => {
      alert(err);
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
          focus={false}
        />
      }
    />
  );
}
