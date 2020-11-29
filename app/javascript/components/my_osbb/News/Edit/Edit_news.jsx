import React from 'react';
import NewsForm from '../NewsForm';



class EditNews extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      long_description: this.props.post.long_description,
      
    };
    this.onSubmit = this.onSubmit.bind(this);
  }

  goBack() {
    window.location.href = '../admin/users/'
  };

  onSubmit(values,long_description) {
    console.log(long_description)
    values.long_description=long_description
    console.log(values)
    const url = `/api/v1/news/${this.props.post.id}`;

    const token = document.querySelector('meta[name="csrf-token"]').content;
    fetch(url, {
      method: "PUT",
      dataType: 'json',
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
      .then(response => window.location.href = `../../myosbb`)
      .catch(error => console.log(error.message))
  }

   render() {
   return (
<div className="container">
        <div className="row mb-5">
          <div className="col-lg-12 text-center">
            <h1 className="mt-5">Edit Post</h1>
          </div>
        </div>
        <NewsForm post = {this.props.post} onSubmit = {this.onSubmit}/>
          </div>

    )
  }
}

export default EditNews
