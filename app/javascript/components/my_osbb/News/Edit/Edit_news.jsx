import React from 'react';
import NewsForm from '../NewsForm';



class EditNews extends React.Component {
  constructor(props) {
    super(props);
    this.onSubmit = this.onSubmit.bind(this);
  }

  onSubmit(values, long_description, image) {
    const formData = new FormData();
    formData.append('title',values.title);
    formData.append('short_description',values.short_description);
    formData.append('long_description',long_description);
    formData.append('is_visible',values.is_visible);
    if (image) formData.append('image',image) ;
    const url = `/api/v1/news/${this.props.post.id}`;

    const token = document.querySelector('meta[name="csrf-token"]').content;
    fetch(url, {
      method: "PUT",
      headers: {
        "X-CSRF-Token": token
      },
      body: formData
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
