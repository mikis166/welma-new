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

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to blog_post_url(@comment.post), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment.post }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
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
