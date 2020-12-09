import React, { Component } from 'react';
import EachComment from './EachComment';
import CommentForm from './CommentForm';
import { Icon, Pagination } from 'semantic-ui-react';


class CommentsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      comments: [],
      totalPages: '',
      currentPage: '',
      parentBlock:[],
      loading: false,

    };

    this.addToState = this.addToState.bind(this);
    this.deleteFromState = this.deleteFromState.bind(this);
    this.setPlaceHolder = this.setPlaceHolder.bind(this);
    this.handlePage = this.handlePage.bind(this);
    this.updateStateByResponse = this.updateStateByResponse.bind(this);
    this.initState = this.initState.bind(this);

  }

  handlePage = (e, {activePage}) => {
    let gotopage = { activePage }
    let pagenum = gotopage.activePage
    let pagestring = pagenum.toString()
    this.setState({
      loading:true
    })
    fetch('/api/v1/news/' + this.props.news_id + '/comments?page='+pagestring)
      .then((response) => {return response.json()})
      .then((data) => {this.initState(data)});
  }

  initState = (data) => {
    this.setState({
      comments: data.comments,
      currentPage: data.pagination.page,
      totalPages: data.pagination.pages,
    })
  }

  componentDidMount(){
    fetch('/api/v1/news/' + this.props.news_id + '/comments.json')
      .then((response) => {return response.json()})
      .then((data) => { this.initState(data) });
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
        news_id={this.props.news_id}
        updateState={this.addToState}
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
      <div className='mx-auto mt-4 d-flex justify-content-center'>
        <Pagination
          onPageChange={this.handlePage}
          siblingRange="6"
          defaultActivePage={currentPage}
          totalPages={totalPages}
          ellipsisItem={{ content: <Icon name='ellipsis horizontal' />, icon: true }}
          firstItem={{ content: <Icon name='angle double left' />, icon: true }}
          lastItem={{ content: <Icon name='angle double right' />, icon: true }}
          prevItem={{ content: <Icon name='angle left' />, icon: true }}
          nextItem={{ content: <Icon name='angle right' />, icon: true }}
        />
      </div>
      </>
    )
  }
}

export default CommentsContainer;