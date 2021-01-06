class NewsChannel < ApplicationCable::Channel
  def subscribed
    @news = News.find(params[:news_id])
    stream_for @news
  end

  #def received(data)
    #NewsChannel.broadcast_to(@news, { news: @news, users: @news.users, comments: @news.comments })
  #end
end
