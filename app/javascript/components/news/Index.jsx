import React from "react"
import News from "./News"

class Index extends React.Component {
  render () {
    return [
      <h1>News</h1>,
      <div className="news-index">
        <News />
      </div>
    ];
  }
}

export default Index