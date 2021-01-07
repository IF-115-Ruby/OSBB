import React, { Component } from 'react';

class CommentsWebSocket extends Component {
    componentDidMount() {
        // the subscriptions.create() method is sending params to the subscribed action in my RoomsChannel
        this.props.cableApp.room = this.props.cableApp.cable.subscriptions.create({
            channel: 'NewsChannel',
            news_id: this.props.news_id
        },
        {
          received: (updatedComments) => {
            this.props.updateState(JSON.parse(updatedComments))
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
