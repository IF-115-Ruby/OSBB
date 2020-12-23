import React, { useState } from 'react'
import { Link } from 'react-router-dom'
import styles from './CreatePost/CreatePost.module.scss'
import { Button } from 'react-bootstrap'
import { Formik, Form, Field, ErrorMessage } from "formik"
import CKEditor from "react-ckeditor-component"

const PostForm = (props)=> {
  const [long_description, setLongDescription] = useState(props.post.long_description)
  const [image, setImage] = useState(null)

  const onChangeCKeditor = (e) => {
    let newContent = e.editor.getData();
    setLongDescription(newContent)  
  } 
  
  const errorMessage = (nameValue, classNameValue)=> {
    return (
      <ErrorMessage
        component="div"
        name={nameValue}
        className={classNameValue}
      />
    )
  }

  return (
    <Formik
        initialValues={props.post}
        validate={values => {
          let errors = {};
          (values.title === "")
          ? errors.title = "Title is required"
          : (values.title.length < 3)
          ? errors.title = "Title must be longer than 3 characters"
          : '';
          ( "" === values.short_description)
          ? errors.short_description = "Short description is required"
          : (values.short_description.length < 3)
          ? errors.short_description = "Short description must be longer than 3 characters"
          : '';
          (long_description === "")
          ? errors.long_description = "Long description is required"
          : (long_description.length < 30)
          ? errors.long_description = "Long description must be longer than 30 characters"
          : '';
          (image && !image.type.includes("image"))
          ? errors.long_description = "Bad image format(only image)"
          : '';
          
          return errors;
        }}
        onSubmit={values =>{props.handleSubmit(values, long_description, image)}}
        >
          {({ touched, errors, isSubmitting }) => (
            <Form className={styles.createForm}>
              <div className="form-group mb-4">
                <label htmlFor="title">Title:</label>
                <Field
                  name="title" className={`form-control ${touched.title && errors.title ? "is-invalid" : ""}`}
                />
                {errorMessage("title", "invalid-feedback")}
              </div>
              <div className="form-group mb-3">
                <label htmlFor="short_description">Short description</label>
                <Field className={`form-control ${
                    touched.short_description && errors.short_description ? "is-invalid" : ""
                  }`}
                  name="short_description"
                />
                {errorMessage("short_description", "invalid-feedback")}
              </div>
              <div className="form-group mb-3">
                <div className="form-group mb-3">
                  <label  htmlFor="image">Image preview: </label>
                </div>
                <input 
                  type="file"
                  name="image"
                  onChange={(e) =>{
                    setImage(e.currentTarget.files[0]);
                  }}
                />
              </div>
              <div className="form-group mb-4 d-flex justify-content-start align-items-baseline">
                <Field name="is_visible" type="checkbox" />
                <div className="pr-2 ml-2 ">
                  <label htmlFor="is_visible">
                    Your post would be visible (If you want to see how your post looks without posting, turn off this check)
                  </label>
                </div>
              </div>
              <div className="form-group mb-4">
                <label htmlFor="long_description">Long description</label>
                <CKEditor content={long_description} name="long_description" activeClass="editor" events={{
                  "change": onChangeCKeditor
                  }}
                  className={`form-control ${
                    touched.short_description && errors.short_description ? "is-invalid" : ""
                  }`}/>
                {errorMessage("long_description", "invalid-feedback d-block")}
              </div>
              <Button type='submit' disabled={isSubmitting}>Submit</Button>
              <Button
                className='ml-3'
                variant="danger"
                as={Link}
                to='/en/account/posts'
                >
                Cancel
              </Button>
            </Form>
          )}
      </Formik>
  )
}

export default PostForm
