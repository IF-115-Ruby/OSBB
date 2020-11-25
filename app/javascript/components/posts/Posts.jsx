import React from 'react'
import { Route, Switch } from 'react-router-dom'
import ShowPost from './ShowPost/ShowPost'
import PostsIndex from './PostsIndex/PostsIndex'
import CreatePost from './CreatePost/CreatePost'
import EditPost from './EditPost/EditPost'

const Posts = () => {
  return (
    <Switch>
      <Route exact path='/:locale/account/posts' component={PostsIndex}/>
      <Route path='/:locale/account/posts/create' component={CreatePost}/>
      <Route exact path='/:locale/account/posts/:id/edit' component={EditPost}/>
      <Route exact path='/:locale/account/posts/:id' component={ShowPost}/>
    </Switch>
  );
}

export default Posts
