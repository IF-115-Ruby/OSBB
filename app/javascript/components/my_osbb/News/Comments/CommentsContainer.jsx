import React, { Component } from 'react';
import EachComment from './EachComment';
import CommentForm from './CommentForm';
import Pagination from 'react-js-pagination';


class CommentsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      comments: [],
      activePage: 1,
      perPage: 5,
      parentBlock:[],
    };

    this.addToState = this.addToState.bind(this);
    this.deleteFromState = this.deleteFromState.bind(this);
    this.setPlaceHolder = this.setPlaceHolder.bind(this);
    this.handlePageChange = this.handlePageChange.bind(this);
    this.updateStateByResponse = this.updateStateByResponse.bind(this);

  }

  componentDidMount(){
    fetch('/api/v1/news/' + this.props.news_id + '/comments.json')
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ comments: data }) });
  };

  handlePageChange = pageNumber => {
    this.setState({activePage: pageNumber});
  }

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
    const activePage = this.state.activePage
    const commentsPerPage = this.state.perPage

    const indexOfLastPost = activePage * commentsPerPage;
    const indexOfFirstPost = indexOfLastPost - commentsPerPage;
    const currentComments = comments.slice( indexOfFirstPost, indexOfLastPost );

    return(
      <>
      <CommentForm
        news_id={this.props.news_id}
        updateState={this.addToState}
        current_user={this.props.current_user}
      />
      {
        currentComments.map((val) => {
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
      <div className='paginationBox'>
        <Pagination
          hideDisabled
          activePage={ activePage }
          itemsCountPerPage={ commentsPerPage }
          totalItemsCount={ comments.length }
          pageRangeDisplayed={ Math.ceil(comments.length / commentsPerPage) }
          onChange={ this.handlePageChange }
        />
      </div>
      </>
    )
  }
}

export default CommentsContainer;