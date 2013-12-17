class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_credentials(params[:user])
    if @user
      session[:token] = @user.reset_session_token
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid username or password"]
      render :new
    end
  end
end
