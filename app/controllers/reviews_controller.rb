class ReviewsController < ApplicationController
  before_action :check_review, only: [:show, :edit, :update, :destroy]
  before_action :building_exists, only: [:new]
  before_action :user_logged_in, only: [:new, :create, :destroy, :edit]

  # TODO: Add edit capabilties
  # TODO: Add delete capabilites

  def new
    @building = Building.find(params[:subject].to_i)
    @review = Review.new
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

  def create
    @review = Review.new(review_params)
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
                                   :author_id,
                                   :subject_id)
  end

  def user_logged_in
    redirect_to root_url if current_user.nil?
  end

  def building_exists
    redirect_to root_url unless Building.exists?(params[:subject].to_i)
  end
end
