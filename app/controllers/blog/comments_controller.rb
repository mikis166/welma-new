class Blog::CommentsController < ApplicationController
  before_filter :authorization
  before_filter :admin_user?, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = "Successfully created..."
      redirect_to :back
    else
      flash[:notice] = "Error creating comment"
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:body,:attachment,:user_id,:post_id)
    end
end
