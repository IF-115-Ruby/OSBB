import React, { Component } from 'react';

class CommentsWebSocket extends Component {
    componentDidMount() {
        // the subscriptions.create() method is sending params to the subscribed action in my RoomsChannel
        this.props.cableApp.room = this.props.cableApp.cable.subscriptions.create({
            channel: 'NewsChannel',
            news_id: this.props.news_id
        },
        {
          received: (updatedNews) => {
            this.props.function(JSON.parse(updatedNews))
          }
        })
    }

    render() {
        return (
            <div></div>
        )
    }
}

export default CommentsWebSocket;
