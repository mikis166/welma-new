class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :stripe_card_token, :email, :password, :password_confirmation) }
    end

    def require_sign_in
      unless user_signed_in?
        redirect_to new_user_session_url, :notice => 'Please register/log in first'
      end
    end

    def admin_user?
      if user_signed_in? && current_user.admin?
        return true
      else
        redirect_to root_url, :notice => 'You do not have enough permissions to access this page'
      end
    end
end
