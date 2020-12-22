import React, { Component } from 'react';
import EachComment from './EachComment';
import { CommentForm } from './forms/CommentForm';
import { PaginationContainer } from './Pagination';
import { getComments } from './requests';

class CommentsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      comments: [],
      totalPages: '',
      currentPage: '',
      parentBlock:[],

    };

    this.addToState = this.addToState.bind(this);
    this.deleteFromState = this.deleteFromState.bind(this);
    this.setPlaceHolder = this.setPlaceHolder.bind(this);
    this.updateStateByResponse = this.updateStateByResponse.bind(this);
    this.changeState = this.changeState.bind(this);
  }

  changeState = (newState) => {
    this.setState( {
      comments: newState.comments,
      currentPage: newState.pagination.page,
      totalPages: newState.pagination.pages,
    })
  }

  componentDidMount(){
    const news_id = this.props.news_id
    getComments(news_id).then(this.changeState).catch((err) => {
      console.log(err);
    });
  };

  addToState = (newComment) => {
    this.setState(prev => ({
      comments: [newComment, ...prev.comments]
    }));
  }

  parent = (val) => {
    if (val.subcomments) {
      return val.id
    }
  }

  deleteFromState = (rem_id) => {
    this.setState(prev => ({
      comments: [...prev.comments.filter( (c) => c.id != rem_id)]
    }));
  }

  setPlaceHolder = (value) => {
    this.setState({ placeHolder: value})
  }

  updateStateByResponse = (value) => {
    this.setState({ parentBlock: value })
    let arr = [...this.state.comments];
    const index = this.state.comments.findIndex(element => element.id == value.id)
    arr[index] = {...arr[index], subcomments: value.subcomments}
    this.setState({comments: arr,});
    this.setState({parentBlock: []});
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
        addToState={this.addToState}
        current_user={this.props.current_user}
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
              onChange={this.deleteFromState}
              setPlaceHolder={this.setPlaceHolder}
              parent={this.parent(val)}
              updateParentBlock={this.updateStateByResponse}
            />
          )
        })
      }
      <PaginationContainer
        currentPage={currentPage}
        totalPages={totalPages}
        changeState={this.changeState}
        news_id={news_id}
      />
      </>
    )
  }
}

export default CommentsContainer;
