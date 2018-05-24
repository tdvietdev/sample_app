class StaticPagesController < ApplicationController

  def about; end

  def contact; end

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page]).per Settings.static_pages.home.microposts_per_page
    end
  end

  def help; end
end
