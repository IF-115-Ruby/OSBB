import React   from 'react';
import styles from './ShowNews.module.scss'
import Tabs from 'react-bootstrap/Tabs'
import Tab from 'react-bootstrap/Tab'

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
            <div className="d-flex align-items-center">
              <span><a className='text-dark' href="/account/news"><i className="fas fa-arrow-left fa-lg"></i></a></span>
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
          <Tabs defaultActiveKey="info" id="uncontrolled-tab-example" className="mt-3">
            <Tab eventKey="info" title="Info">
              <div className={styles.text_news} dangerouslySetInnerHTML={this.longDescription()}></div>
            </Tab>
            <Tab eventKey="comments" title="Comments" disabled>{/* This space for comments!*/}</Tab>
          </Tabs>
        </div>
      </div>
    )
  }
}

export default ShowNews
