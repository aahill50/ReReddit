class SubsController < ApplicationController
  before_filter only: [:show, :edit, :update, :destroy] do
    set_sub
  end

  before_filter only: [:edit, :update, :destroy] do
    unless @sub.moderator == current_user
      render "You can't do that!", status: :forbidden
    end
  end

  def all
    @subs = Sub.all
    render :all
  end

  def index
    @subs = User.find(params[:user_id]).subs
    render :index
  end

  def show
    render :show
  end

  def new
    @sub = current_user.subs.new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy

  end

private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def set_sub
    @sub = Sub.find(params[:id])
  end
end
