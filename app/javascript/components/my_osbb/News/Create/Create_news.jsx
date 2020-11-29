import React from 'react';
import { Formik, Form, Field, ErrorMessage } from "formik";
import CKEditor from "react-ckeditor-component";
import NewsForm from '../NewsForm';


class CreateNews extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      long_description: "",
      
    };
    this.onSubmit = this.onSubmit.bind(this);
    this.onChangeCKeditor = this.onChangeCKeditor.bind(this);
  }

  onChangeCKeditor(evt){
    let newContent = evt.editor.getData();
    this.setState({ long_description: newContent })
  }

  goBack() {
    window.location.href = '../admin/users/'
  };

  onSubmit(values, long_description) {
    values.long_description=long_description

    const url = "/api/v1/news";

    const token = document.querySelector('meta[name="csrf-token"]').content;
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json"
      },
      body: JSON.stringify(values)
    })
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then(response => window.location.href = `../news/${response.id}`)
      .catch(error => console.log(error.message))
  }

   render() {
   return (
<div className="container">
        <div className="row mb-5">
          <div className="col-lg-12 text-center">
            <h1 className="mt-5">Add Post</h1>
          </div>
        </div>
        <NewsForm onSubmit = {this.onSubmit} post = {{title: "", short_description: "", long_description: "", is_visible: "",news_image: null}}/>
          </div>
/* <div className="container">
<h1 className="display-3">Add News</h1>
<div className="news-form">
      <form onSubmit={this.onSubmit}>
      <div className="form-group">
      <div className="form-control mb-2">
        <label>Title</label>
        <input onChange={this.onChange} type="text" name="title"/>
      </div> 
      </div>
      <br/>
      <div className="form-group">
      <div className="form-control mb-2">
        <label>Short description</label>
        <input onChange={this.onChange} type="text" name="short_description"/>
      </div> 
      </div>
      <br/>
      <div className="form-group">
      <div className="form-control mb-2">
        <label>Long description</label>
        <input onChange={this.onChange} type="text" name="long_description"/>
      </div> 
      </div>
      <br/>
      <div>
      <div className="form-group">
        <button className="btn-primary btn" type="submit" >
          Submit
        </button>
        <button className="btn-primary btn" type="button" >
          Clear Values
        </button>
        </div>
      </div>
    </form>
    </div>
    </div> */
    )
  }
}

export default CreateNews
