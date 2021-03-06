class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if user
      login!(user)
      redirect_to root_url
    else
      @user = User.new(email: params[:user][:email])
      flash.now[:errors] = ["Unable to sign in, buddy!"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end
end
