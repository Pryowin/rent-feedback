class UsersController < ApplicationController
  # Prevents edit/delete of Users
  # Ensures that non-admin users can only view their own profile
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
    redirect_to root_url unless current_or_admin?(params[:id])
  end

  private

  def current_or_admin?(id)
    return false unless User.exists?(id.to_i)
    return false if current_user.nil?
    @user = User.find(id.to_i)
    return true if current_user.admin
    return true if current_user == @user
    false
  end
end
