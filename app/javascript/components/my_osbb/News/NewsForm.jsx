import React from 'react';
import { Formik, Form, Field, ErrorMessage } from "formik";
import CKEditor from "react-ckeditor-component";


class NewsForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      long_description: this.props.post.long_description ? this.props.post.long_description : "",
      
    };
    this.onChangeCKeditor = this.onChangeCKeditor.bind(this);
  }

  onChangeCKeditor(evt){
    let newContent = evt.editor.getData();
    this.setState({ long_description: newContent })
  }

   render() {
     console.log(this.props.image)
   return (
            <Formik
              initialValues={{ title: this.props.post.title, short_description: this.props.post.short_description , long_description: this.props.post.long_description , is_visible: this.props.post.is_visible}}
              validate={values => {
                let errors = {};
                if (values.title === "") {
                  errors.title = "title is required";
                } else if (values.title.length < 3) {
                  errors.title = "Invalid title address format";
                }
                if (values.short_description === "") {
                  errors.short_description = "short_description is required";
                } else if (values.short_description.length < 3) {
                  errors.short_description = "short_description must be 3 characters at minimum";
                }
                if (this.state.long_description === "") {
                  errors.long_description = "long_description is required";
                } else if (this.state.long_description.length < 3) {
                  errors.long_description = "long_description must be 3 characters at minimum";
                }
                return errors;
              }}
              onSubmit={values =>{this.props.onSubmit(values, this.state.long_description)}}
            >
              {({ touched, errors, isSubmitting }) => (
                <Form className="news-form">
                  <div className="form-group mb-4">
                    <label htmlFor="title">Title</label>
                    <Field
                      name="title"
                      className={`form-control ${
                        touched.title && errors.title ? "is-invalid" : ""
                      }`}
                    />
                    <ErrorMessage
                      component="div"
                      name="title"
                      className="invalid-feedback"
                    />
                  </div>

                  <div className="form-group mb-4">
                    <label htmlFor="short_description">Short description</label>
                    <Field
                      name="short_description"
                      className={`form-control ${
                        touched.short_description && errors.short_description ? "is-invalid" : ""
                      }`}
                    />
                    <ErrorMessage
                      component="div"
                      name="short_description"
                      className="invalid-feedback"
                    />
                  </div>
                  <div className="form-group mb-4">
                  <div className="form-group mb-4">
                    <label  htmlFor="news_image">Image preview:</label>
                    </div>
                    <Field name="news_image"  type="file" />
                    </div>
                  <div className="form-group mb-4">
                    <Field name="is_visible" type="checkbox" />
                    <div className="pr-2">
                    <label htmlFor="is_visible">Your post would be visible (If you want to see how your post looks without posting, turn off this check) </label>
                    </div>
                </div>
                <div className="form-group mb-4">
                    <label htmlFor="long_description">Long description</label>
                    <CKEditor content={this.state.long_description} name="long_description" activeClass="editor" events={{
                "change": this.onChangeCKeditor
              }}
                      className={`form-control ${
                        touched.short_description && errors.short_description ? "is-invalid" : ""
                      }`}/>
                    <ErrorMessage
                      component="div"
                      name="long_description"
                      className="invalid-feedback d-block"
                    />
                  </div>
                  <button
                    type="submit"
                    className="btn btn-primary btn-block"
                  >
                    Submit
                  </button>
                </Form>
              )}
            </Formik>
    )
  }
}

export default NewsForm
