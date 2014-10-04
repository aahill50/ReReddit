class CommentsController < ApplicationController
  def new
    @comment = current_user.comments.new  
    @comment.post_id = params[:post_id]
    @parent = params[:comment_id] ? Comment.find(params[:comment_id]) : nil
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:comment][:post_id]
    @comment.parent_comment_id = params[:comment][:parent_id]

    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
