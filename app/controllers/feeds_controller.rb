class FeedsController < ApplicationController
  def new
    @feed = current_user.feeds.build
  end

  def index
    @feed = Feed.new
    @feeds = Feed.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
  end

  def create
    @feed = current_user.feeds.build(feed_params)
    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feeds, notice: 'Post was successfully created.' }
        format.js
      else
        format.html { render action: "index" }
        format.js
      end
    end
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    @feed = Feed.find(params[:id])
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to feeds_path }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def show
    @feed = Feed.find(params[:id])
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url,notice: 'Post was successfully deleted.' }
      format.js
    end
  end

  private
  def feed_params
    params.require(:feed).permit(:title,:description)
  end
end
