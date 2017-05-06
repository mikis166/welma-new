class UsersController < ApplicationController
  before_action :authenticate_user!


  def index
  	@users = User.includes(:profile)
  end


  def show
    @user = User.find( params[:id] )

    session[:conversations] ||= []

    # @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
  end
end
