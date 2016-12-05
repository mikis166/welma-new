class Blog::CommentsController < ApplicationController

  before_filter :require_sign_in
  before_action :authenticate_user!
  # skip_before_filter  :verify_authenticity_token
  before_action :creator?, except: [:create]

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    respond_to do |format|
      format.js
    end

  end

  def update
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    respond_to do |format|
      if @comment.update(comment_params)
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_post_url(@comment.post), notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body,:attachment,:user_id,:post_id)
    end

    def creator?
      @comment = Comment.find_by(id: params[:id])
      unless current_user == @comment.user
        redirect_to blog_post_url(@comment.post)
        flash[:notice] = "You are authorized to commit any action to this comment."
      end
    end
end
