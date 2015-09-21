class Blog::WelcomeController < ApplicationController
  before_filter :require_sign_in

  def index
    @blog = true
    @posts = Post.all
  end
end
