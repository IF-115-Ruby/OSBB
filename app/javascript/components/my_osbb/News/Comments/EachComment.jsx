import React, { createElement, useState } from 'react';
import { Comment, Avatar, Tooltip, } from 'antd';
import 'antd/dist/antd.css';
import { DislikeOutlined, LikeOutlined, DislikeFilled, LikeFilled } from '@ant-design/icons';
import styles from './Comments.module.scss';
import axios from 'axios';
import ReplyForm from './ReplyForm';


const EachComment = ( { comment, time, name, avatar, subcomments, id, onChange, parent, updateParentBlock, updateParent, news_id } ) => {

  const [likes, setLikes] = useState(0);
  const [dislikes, setDislikes] = useState(0);
  const [action, setAction] = useState(null);
  const [placeHolder, setPlaceHolder] = useState(null);

  const like = () => {
    setLikes(1);
    setDislikes(0);
    setAction('liked');
  };

  const dislike = () => {
    setLikes(0);
    setDislikes(1);
    setAction('disliked');
  };

  const updateState = () => {
    onChange(id)
  }

  const reply = () => {
    setPlaceHolder(`@${name}, `);
    // updateParent(parent)
  }

  const handleDelete = () => {
    const token = document.querySelector('[name=csrf-token]').content
    axios.defaults.headers.common['X-CSRF-TOKEN'] = token
    axios.delete('/api/v1/comments/'+ id, {
      params: {
        parent_comment: parent,
        news_id: news_id,
      }
    })
      .then((response) => {
        console.log(response);
        updateParentBlock(response.data)
        updateState();
      })
      .catch((error) => {
        alert(error);
      });
  }

  const actions = [
    <Tooltip key="comment-basic-like" title="Like">
      <span onClick={like}>
        {createElement(action === 'liked' ? LikeFilled : LikeOutlined)}
        <span className="comment-action">{likes}</span>
      </span>
    </Tooltip>,
    <Tooltip key="comment-basic-dislike" title="Dislike">
      <span onClick={dislike}>
        {React.createElement(action === 'disliked' ? DislikeFilled : DislikeOutlined)}
        <span className="comment-action">{dislikes}</span>
      </span>
    </Tooltip>,
    <span key="comment-basic-reply-to" onClick={reply}>Reply to</span>,
    <span key="comment-basic-delete" onClick={handleDelete}>Delete</span>,
  ];

  const nestedComment = () => {
    if (subcomments) {
      return subcomments.map(c => (
        <EachComment
          key={c.id}
          id={c.id}
          time={c.time}
          name= {c.user_full_name}
          avatar={c.user_avatar}
          comment={c.body}
          subcomments={c.subcomments}
          onChange={onChange}
          parent={parent}
          setPlaceHolder={setPlaceHolder}
          updateParentBlock={updateParentBlock}
          updateParent={updateParent}
          news_id={news_id}
        />
      ))
    }
  }

  return(
    <>
    <Comment
      actions={actions}
      author= { name }
      avatar={
        <Avatar
          src= { avatar }
          alt= { name }
        />
      }
      content={
        <p className={styles.p}>{ comment }</p>
      }
      datetime={ time }
    >
      {/* <ReplyForm
      key={id}
      id={id}
      onChange={onChange}
      parent={parent}
      setPlaceHolder={setPlaceHolder}
      updateParentBlock={updateParentBlock}
      updateParent={updateParent}
      news_id={news_id}
      placeHolder={placeHolder}
      /> */}
      { nestedComment() }

    </Comment>
  </>
  )
}

export default EachComment;
