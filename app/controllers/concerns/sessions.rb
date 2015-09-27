module Sessions extend ActiveSupport::Concern

  def requires_authenticated_user
    if current_user.nil?
      flash[:danger] = "Please log in."
      redirect_to '/users/sign_in'
    end
  end

  def requires_admin_user
    if !current_user.admin
      redirect_to root_url
    end
  end

end
