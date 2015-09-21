class Blog::WelcomeController < ApplicationController
  before_filter :require_sign_in

  def index
    @blog = true
    @posts = Post.paginate(:page => params[:page],:per_page => 15)
  end
end
