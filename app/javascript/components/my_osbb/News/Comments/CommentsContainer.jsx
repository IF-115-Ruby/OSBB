import React, { Component } from 'react';
import EachComment from './EachComment';
import { CommentForm } from './forms/CommentForm';
import { PaginationContainer } from './Pagination';
import { getComments } from './requests';
import CommentsWebSocket from './CommentsWebSocket'

class CommentsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      comments: [],
      totalPages: '',
      currentPage: '1'
    };

    this.setPlaceHolder = this.setPlaceHolder.bind(this);
    this.updateState = this.updateState.bind(this);
  }


  updateState = (newState) => {
    if (newState.pagination.page == this.state.currentPage) {
      this.setState( {
        comments: newState.comments,
        currentPage: newState.pagination.page,
        totalPages: newState.pagination.pages,
      })
    }
  }

  componentDidMount(){
    const news_id = this.props.news_id
    getComments(news_id).then(this.updateState).catch((err) => {
      alert(err);
    });
  };

  parent = (val) => {
    if (val.subcomments) {
      return val.id
    }
  }

  setPlaceHolder = (value) => {
    this.setState({ placeHolder: value})
  }

  render(){
    const comments = this.state.comments
    const news_id = this.props.news_id
    const currentPage = this.state.currentPage
    const totalPages = this.state.totalPages

    return(
      <>
      <CommentForm
        news_id={news_id}
        current_user={this.props.current_user}
        page={this.state.currentPage}
      />
      {
        comments.map((val) => {
          return (
            <EachComment
              key={val.id}
              id={val.id}
              comment={val.body}
              time={val.time}
              avatar={val.user_avatar}
              name={val.user_full_name}
              subcomments={val.subcomments}
              news_id={news_id}
              setPlaceHolder={this.setPlaceHolder}
              parent={this.parent(val)}
              page={this.state.currentPage}
            />
          )
        })
      }
      <PaginationContainer
        currentPage={currentPage}
        totalPages={totalPages}
        updateState={this.updateState}
        news_id={news_id}
      />
      <CommentsWebSocket
          cableApp={this.props.cableApp}
          news_id={this.props.news_id}
          updateState={this.updateState}
      />
      </>
    )
  }
}

export default CommentsContainer;
