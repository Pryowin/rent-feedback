class UsersController < ApplicationController
  def new
  end

  def index
    redirect_to root_url
  end

  def edit
    redirect_to root_url
  end

  def destroy
    redirect_to root_url
  end

  def show

    if !User.exists?(params[:id])
      redirect_to root_url
      return
    end

    @user = User.find(params[:id])

    if current_user != @user
      redirect_to root_url
    end
  end

end
