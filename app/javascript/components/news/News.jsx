import React from "react"
import NewsItem from "./NewsItem"

class News extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      news: []
    };
  }

  componentDidMount() {
    fetch('/api/v1/news')
      .then((response) => { return response.json() })
      .then((data) => { this.setState({ news: data }) });
  }

  render() {
    var news = this.state.news.map((newsItem) => {
      return (
        <NewsItem newsItem={newsItem} key={newsItem.id}/>
      )
    })
    AddStyleForParent();
    return (
      <div className = "container">
        <AddButton/>
        <div className = "items-container">
          {news}
        </div>
      </div>
    )
  }
}

function AddButton() {
  return [
    <a rel="New post" href="news/new" className = "btn btn-primary">Add News</a>
  ]
}

function AddStyleForParent() {
  var el = document.getElementsByClassName("user-index")[0];
  if (el) {
    parent = el.parentNode;
    parent.className = "container-wrapper-news";
  }
}

export default News