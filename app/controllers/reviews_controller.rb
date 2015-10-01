class ReviewsController < ApplicationController
  def new
  end

  def edit
  end

  def show
    @review = Review.find(params[:id].to_i)
  end

  def index
    redirect_to root_url
  end
end
