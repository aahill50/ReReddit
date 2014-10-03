class PostsController < ApplicationController
  before_filter :set_post, only: [:edit, :update, :show]
  before_filter :check_post_author, only: [:edit, :update]

  def new
    @post = current_user.posts.new
    @sub = params[:sub_id]
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.sub_id = params[:sub_id]
    #Need to also create post sub entry
    if @post.save
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @post.update(post_params)
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    render :show
  end

  private

  def check_post_author
    render text: "You can't do that", status: :forbidden unless current_user == @post.author
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :url)
  end
end
