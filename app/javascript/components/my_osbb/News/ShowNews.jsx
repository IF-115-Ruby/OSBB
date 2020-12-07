import React   from 'react';
import styles from './ShowNews.module.scss'
import CommentsContainer from './Comments/CommentsContainer'


class ShowNews extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      news: []
    };
  }

  longDescription = () => {
    return { __html: this.state.news.long_description };
  }

  not_visible = () => {
    if (!this.state.news.is_visible) {
      return <span><i className="fas fa-eye-slash fa-lg"></i></span>
    }
  }

  componentDidMount() {
    fetch('/api/v1/news/'+ this.props.news_id)
      .then((response) => { return response.json() })
      .then((data) => { this.setState({ news: data }) });
  }

   render() {
    return (
      <div className={styles.news_main_div}>
        <div className={styles.news_form}>
          <div className={styles.title_news}>
            <div className="d-flex justify-content-around flex-wrap align-items-center">
              <span><a className='text-dark' href="/en/account/myosbb/"><i className="fas fa-arrow-left fa-lg"></i></a></span>
              {this.not_visible()}
            </div>
            <h1 className="title"> {this.state.news.title}</h1>
            <div className="d-flex justify-content-around flex-wrap align-items-center">
              <span><a className='text-dark' href={`/account/news/${this.state.news.id}/edit`}><i id="edit" className="fas fa-edit fa-lg"></i></a></span>
              <span><a className='text-dark' data-confirm="Are you sure?" rel="nofollow" data-method="delete" href={`/account/news/${this.state.news.id}/`}>
                <i id="delete" className="fas fa-trash-alt fa-lg"></i></a></span>
            </div>
          </div>
          <div className={styles.img_div} >
            <img src={ this.state.news.show_image } alt='Image' className = {styles.news_img}></img>
          </div>
          <div className={styles.text_news} dangerouslySetInnerHTML={this.longDescription()}></div>
          <CommentsContainer news_id={this.props.news_id} current_user={this.props.current_user}/>
        </div>
      </div>
    )
  }
}

export default ShowNews
