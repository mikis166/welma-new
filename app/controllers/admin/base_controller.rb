class Admin::BaseController < ApplicationController
  before_filter :access_admins_only

  private
    def access_admins_only
      unless user_signed_in? && current_user.admin?
        redirect_to root_path
      end
    end

end
