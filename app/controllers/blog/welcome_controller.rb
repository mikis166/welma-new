class Blog::WelcomeController < ApplicationController
  before_filter :authorization

  def index
    @blog = true
    @posts = Post.all
  end
end
