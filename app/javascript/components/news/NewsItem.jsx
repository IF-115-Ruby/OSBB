import React from "react"
import PropTypes from "prop-types"

class NewsItem extends React.Component {
  render () {
    let newsItem = this.props.newsItem;
    return (
      <div className="col-md-4 user-size-item">
          <div className="user-hidden-block">
    {true && (<NewsItemInfo newsItem={newsItem} />)} 
          </div>
        </div>
    );
  }
}

function NewsItemInfo(newsItem) {
  return [
    <div className="news-item">
      <div className="news-form">
        <h2>Title: {newsItem.newsItem.title}</h2>,
        <p>Description: {newsItem.newsItem.short_description}</p>
      </div>
    </div>,
    <hr />
  ]
}

function updateRequest(id, data) {
  fetch('/account/news/' + id, {
    method: 'put',
    body: JSON.stringify(data),
    headers: { 'Content-Type': 'application/json' },
  }).then((response) => {
    location.href = document.location.pathname;
    console.log(response);
  });
}

export default NewsItem