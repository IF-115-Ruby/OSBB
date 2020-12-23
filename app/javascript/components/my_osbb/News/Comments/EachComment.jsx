import React, { createElement, useState } from 'react';
import { Comment, Avatar, Tooltip, } from 'antd';
import 'antd/dist/antd.css';
import { DislikeOutlined, LikeOutlined, DislikeFilled, LikeFilled } from '@ant-design/icons';
import styles from './Comments.module.scss';
import ReplyForm from './forms/ReplyForm';
import { formatReply } from './_commentsHelper';
import { deleteComment } from './requests';

const EachComment = ( { comment, time, name, avatar, subcomments, id, onChange, parent, updateParentBlock, updateParent, news_id } ) => {

  const [likes, setLikes] = useState(0);
  const [dislikes, setDislikes] = useState(0);
  const [action, setAction] = useState(null);
  const [placeHolder, setPlaceHolder] = useState(null);
  const [showReply, setShowReply] = useState(false);
  const [showSubcomments, setShowSubcomments] = useState(false)

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

  const reply = () => {
    setShowReply(!showReply);
    setPlaceHolder(`@${name}, `);
  }

  const hideReply = () => {
    setShowReply(false);
  }

  const showMore = () => {
    setShowSubcomments(!showSubcomments);
  }

  const handleDelete = () => {
    deleteComment(id, parent, news_id).then(res => {
      (res=='done') ? onChange(id) : updateParentBlock(res)
    }).catch((err) => {
      console.log(err);
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
    <span key="comment-basic-reply-to" onClick={reply}>{ showReply ? 'Cancel' : 'Reply to' }</span>,
    <span key="comment-basic-delete" onClick={handleDelete}>Delete</span>,
  ];

  const nestedComment = () => {
    if (subcomments) {
      return subcomments.map( (c, i) => (
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
        <p className={styles.textIndentForComments}>{ comment }</p>
      }
      datetime={ time }
    >
     <ReplyForm
      key={id}
      id={id}
      onChange={onChange}
      parent={parent ? parent : id}
      updateParentBlock={updateParentBlock}
      updateParent={updateParent}
      news_id={news_id}
      placeHolder={placeHolder}
      setPlaceHolder={setPlaceHolder}
      hideReply={hideReply}
      showReply={showReply}
      />
    { showSubcomments && nestedComment() }
    <div className="media position-relative">
    {
      subcomments &&
      <a onClick={showMore} className="stretched-link">
        <span>{ formatReply(subcomments.length, showSubcomments) }</span>
      </a>
    }
    </div>
    </Comment>
  </>
  )
}

export default EachComment;
