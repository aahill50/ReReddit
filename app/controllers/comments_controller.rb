class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    flash[:errors] = @comment.errors.full_messages unless @comment.save
    redirect_to post_url(@comment.post)
  end

  def create_child
    @parent_comment = Comment.find(params[:id])
    @child_comment = @parent_comment.child_comments.new(comment_params)
    @child_comment.author = current_user
    @child_comment.post_id = @parent_comment.post_id
    flash[:errors] = @child_comment.errors.full_messages unless @child_comment.save
    redirect_to post_url(@parent_comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
