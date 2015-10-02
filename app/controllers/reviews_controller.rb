class ReviewsController < ApplicationController
  before_action :check_review, only: [:show, :edit, :update, :destroy]

  def new
  end

  def edit
    @review = Review.find(params[:id].to_i)
    @author = User.find(@review.author_id)
    @building = Building.find(@review.subject_id)
    redirect_to root_url unless current_user == @author
  end

  def show
    @review = Review.find(params[:id].to_i)
    @author = User.find(@review.author_id)
    @building = Building.find(@review.subject_id)
  end

  def index
    redirect_to root_url
  end

  private

  def check_review
    redirect_to root_url unless Review.exists?(params[:id].to_i)
  end

end
