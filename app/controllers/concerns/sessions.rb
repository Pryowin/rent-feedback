module Sessions extend ActiveSupport::Concern
                def requires_authenticated_user
                  return unless current_user.nil?
                  flash[:danger] = 'Please log in.'
                  redirect_to '/users/sign_in'
                end

                def requires_admin_user
                  redirect_to root_url unless current_user.admin
                end
end
