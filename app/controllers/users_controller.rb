class UsersController < ApplicationController

  def new

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:token] = @user.reset_token
      #redirect somewhere
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def send_reset_email
    @user = User.find_by_email(params[:user][:email])
    @user.reset_token = SecureRandom.urlsafe_base64(16)
    @user.save!

    msg = UserMailer.forgot_email(@user)
    msg.deliver!

    redirect_to new_session_url
  end

  def forgot_password
    render :forgot_password
  end

  def reset_password
    redirect_to new_session_url unless correct_reset_token?
    session[:reset_token] = nil
    render :reset_password
  end

  def reset_page
    session[:reset_token] = params[:reset_token]
    render :reset_page
  end

  def get_reset_token_by_email(email)
    User.find_by_email(email).reset_token
  end

  def corret_reset_token?
    @user = User.find_by_email(params[:user][:email])
    session[:reset_token] == user.reset_token
  end

end