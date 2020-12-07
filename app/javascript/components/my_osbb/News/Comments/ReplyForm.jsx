import React, { Component } from 'react'
import { Comment, Form, Button, Input} from 'antd';
import 'antd/dist/antd.css';
import axios from 'axios';


const { TextArea } = Input;

const Editor = ({ onChange, onSubmit, submitting, value }) => (
  <>
    <Form.Item>
      <TextArea rows={2} onChange={onChange} value={value} />
    </Form.Item>
    <Form.Item>
      <Button htmlType="submit" loading={submitting} onClick={onSubmit} type="primary">
        Reply
      </Button>
    </Form.Item>
  </>
);

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

    let formData = new FormData();
    formData.append('body', this.state.value);

    const token = document.querySelector('[name=csrf-token]').content;
    axios.defaults.headers.common['X-CSRF-TOKEN'] = token;

    axios({
      method: 'post',
      url: '/api/v1/comments/'+ this.props.id +'/comments',
      data: formData,
      params: {news_id: this.props.news_id},
      headers: {'Content-Type': 'multipart/form-data' }
      })
      .then((response) => {
        console.log(response);
        this.props.updateParentBlock(response.data)
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

export default ReplyForm