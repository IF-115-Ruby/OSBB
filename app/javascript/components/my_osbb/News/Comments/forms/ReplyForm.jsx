import React, { Component } from 'react'
import { Comment } from 'antd';
import 'antd/dist/antd.css';
import { Editor } from './Editor';
import { createComment } from '../requests';

class ReplyForm extends Component {
  constructor(props){
    super(props)
    this.state = {
      value: '',
      submitting: false,
      placeHolder: '',
    }

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  componentDidUpdate(prev) {
    if (prev.placeHolder !== this.props.placeHolder) {
      this.setState({value: this.props.placeHolder})
    }
  }

  handleChange = e => {
    this.setState({
      value: e.target.value
    });
  };

  handleSubmit = () => {
    if (!this.state.value) {
      return;
    }

    this.setState({
      submitting: true,
    });

    const url = '/api/v1/comments/'+ this.props.parent + '/comments'

    createComment(url, this.props.news_id, {'Content-Type': 'multipart/form-data' }, this.state.value, this.props.page).catch((err) => {
      console.log(err);
    });

    setTimeout(() => {
      this.setState({
        submitting: false,
        value: '',
      });
      this.props.hideReply();
      this.props.setPlaceHolder('');
    }, 1000);
  };

  render() {
    const { submitting, value } = this.state;

    return (
      <>
        {this.props.showReply && <Comment
          content={
            <Editor
              onChange={this.handleChange}
              onSubmit={this.handleSubmit}
              submitting={submitting}
              value={value}
              focus={true}
            />
          }
        />}
      </>
    );
  }
}

export default ReplyForm;
