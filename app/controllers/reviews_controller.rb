class ReviewsController < ApplicationController
  before_action :check_review, only: [:show, :edit, :update, :destroy]
  before_action :building_exists, only: [:new]
  before_action :user_logged_in, only: [:new, :create, :destroy, :edit]
  before_action :author_of_review?, only:[:edit, :destroy]

  def new
    @building = Building.find(params[:subject].to_i)
    @review = Review.new
  end

  def destroy
    @review = Review.find(params[:id].to_i)
    @author = User.find(@review.author_id)
    @review.destroy
    redirect_to user_path, id:@author.id
  end

  def edit 
    @review = Review.find(params[:id].to_i)
    @author = User.find(@review.author_id)
    @building = Building.find(@review.subject_id)
  end

  def update
    @review = Review.find(params[:id].to_i)
    @review.from_year = date_field(params[:date][:from_year])
    @review.from_month = date_field(params[:date][:from_month])
    @review.to_month = date_field(params[:date][:to_month])
    @review.to_year = date_field(params[:date][:to_year])
    @building = Building.find(params[:subject_id])
    @author = current_user
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review Edited' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        err = @review.errors
        format.json { render json: err, status: :unprocessable_entity }
      end
    end
  end

  def show
    @review = Review.find(params[:id].to_i)
    @author = User.find(@review.author_id)
    @building = Building.find(@review.subject_id)
  end

  def index
    redirect_to root_url
  end

  def create
    @review = Review.new(review_params)
    @review.from_year = date_field(params[:date][:from_year])
    @review.from_month = date_field(params[:date][:from_month])
    @review.to_month = date_field(params[:date][:to_month])
    @review.to_year = date_field(params[:date][:to_year])
    @author = current_user
    @building = Building.find(params[:subject_id])
    @review.author_id = current_user.id
    @review.subject_id = params[:subject_id]
    respond_to do |format|
      if @review.save
        format.html { redirect_to @building, notice: 'Review added' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        err = @review.errors
        format.json { render json: err, status: :unprocessable_entity }
      end
    end
  end

  private

  def check_review
    redirect_to root_url unless Review.exists?(params[:id].to_i)
  end

  def review_params
    params.require(:review).permit(:headline,
                                   :overall_rating,
                                   :value_rating,
                                   :cleanliness_rating,
                                   :location_rating,
                                   :facilities_rating,
                                   :details,
                                   :date,
                                   :from_year,
                                   :from_month,
                                   :to_year,
                                   :to_month)
  end

  def author_of_review?
    review = Review.find(params[:id].to_i)
    redirect_to root_url unless current_user.id == review.author_id
  end

  def user_logged_in
    redirect_to root_url if current_user.nil?
  end

  def building_exists
    redirect_to root_url unless Building.exists?(params[:subject].to_i)
  end
end

def date_field(value)
  return 0 if value.empty?
  return value
end
