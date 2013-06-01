class Api::PagesController < ApplicationController
  respond_to :json, :xml

  def index
    @pages = Page.all
    respond_with @pages
  end

  def show
    @page = Page.find(params[:id])
    respond_with @page
  end

  def new
    @page = Page.new
    render_with @page
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      render_with @page
    else
      render_with @page.errors, status: :unprocessable_entity
    end
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      render_with @page
    else
      render_with @page.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    respond_with [:api, @page]
  end
  
  def published
    @published_pages = Page.published_pages
    respond_with @published_pages
  end
  
  def unpublished
    @unpublished_pages = Page.unpublished_pages
    respond_with @unpublished_pages
  end
  
  def publish
    @page = Page.find(params[:id])
    @page.publish_now
    @page.save
    respond_with @page
  end
  
  def total_words
    @page = Page.find(params[:id])
    respond_with @page.words
  end
end
