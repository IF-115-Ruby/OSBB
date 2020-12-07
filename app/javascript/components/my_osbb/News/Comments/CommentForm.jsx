import React, { Component } from 'react';
import { Comment, Avatar, Form, Button, Input} from 'antd';
import 'antd/dist/antd.css';
import axios from 'axios';


const { TextArea } = Input;

const Editor = ({ onChange, onSubmit, submitting, value }) => (
  <>
    <Form.Item>
      <TextArea rows={4} onChange={onChange} value={value} />
    </Form.Item>
    <Form.Item>
      <Button htmlType="submit" loading={submitting} onClick={onSubmit} type="primary">
        Add Comment
      </Button>
    </Form.Item>
  </>
);

class CommentForm extends Component {
  constructor(props){
    super(props)
    this.state = {
      value: '',
      submitting: false,
    }

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.addComment = this.addComment.bind(this);
  }

  addComment = (comment_id) => {
    this.props.updateState({
      'body': this.state.value,
      'id': comment_id,
      'time': 'less than a minute ago ',
      'user_avatar': this.props.current_user.avatar,
      'user_full_name': this.props.current_user.full_name,
    });
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

    let formData = new FormData();
    formData.append('body', this.state.value);

    const token = document.querySelector('[name=csrf-token]').content;
    axios.defaults.headers.common['X-CSRF-TOKEN'] = token;

    axios({
      method: 'post',
      url: '/api/v1/news/' + this.props.news_id + '/comments',
      data: formData,
      headers: {'Content-Type': 'multipart/form-data' }
      })
      .then((response) => {
        console.log(response);
        this.addComment(response.data.id);
      })
      .catch((response) => {
          console.log(response);
      });

    setTimeout(() => {
      this.setState({
        submitting: false,
        value: '',
      });
    }, 1000);
  };

  render() {
    const { submitting, value } = this.state;

    return (
      <>
        <Comment
          avatar={
            <Avatar
              src= { this.props.current_user.avatar }
              alt= { this.props.current_user.full_name }
            />
          }
          content={
            <Editor
              onChange={this.handleChange}
              onSubmit={this.handleSubmit}
              submitting={submitting}
              value={value}
            />
          }
        />
      </>
    );
  }
}

export default CommentForm;
