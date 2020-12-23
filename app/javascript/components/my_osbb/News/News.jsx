import React from "react"
import PropTypes from "prop-types"
import NewsItem from './NewsItem/NewsItem'
import styles from './News.module.scss'
import { Pagination } from 'semantic-ui-react'

class News extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      news: [],
      page: [],
      pages: []
    };
  }

  componentDidMount() {
    fetch('/api/v1/news')
      .then((response) => {return response.json()})
      .then((data) => {this.setState({
        news: data.news,
        page: data.current_page,
        pages: data.total_pages
      }) });
  }

  handleSwitchPage = (e, {activePage}) => {
    this.setState({
      loading:true
    })
    fetch('/api/v1/news/?page='+ activePage)
      .then((response) => {return response.json()})
      .then((data) => {this.setState({
        news: data.news
       }) });
  }

  render () {
    const { news, page, pages } = this.state

    var newsList = news.map((news) => {
      return( <NewsItem attributes={news} /> )
    })

    return (
      <div className={styles.itemsContainer}>
        <AddButton/>
        {newsList}
        {
          pages < 2 ? null :
          <div className={styles.pagination}>
            <Pagination onPageChange={this.handleSwitchPage} siblingRange='8' defaultActivePage={page} totalPages={pages} />
          </div>
        }
      </div>
    )

    function AddButton() {
      return [ <a rel="New post" href="../../account/news/new" className = "btn btn-primary">Add News</a> ]
    }
  }
}

export default News
