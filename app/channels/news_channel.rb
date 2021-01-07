class NewsChannel < ApplicationCable::Channel
  def subscribed
    @news = News.find(params[:news_id])
    stream_for @news
  end
end
