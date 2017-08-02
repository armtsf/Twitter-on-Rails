class PageController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @tweet = Tweet.new if signed_in?
      @feed_items = current_user.feed.all
    end
  end
end
