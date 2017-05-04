class Admin::UsersController < Admin::BaseController

  def index
    @users = User.includes(:profile).order("id ASC")
  end

  def destroy
    user = User.find_by_id(params[:id])
    if user.destroy
      flash[:notice] = "Success! User deleted."
    else
      flash[:alert] = "Something went wrong!"
    end
    redirect_to :back
  end

end
