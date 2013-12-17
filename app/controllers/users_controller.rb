class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id])
    render :show
  end

  def new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:token] = @user.reset_token
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.password_digest = nil
    if @user.update_attributes(params[:user])
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :reset_password_form
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

  def reset_password_form
    session[:reset_token] = params[:reset_token]
    redirect_to new_session_url unless correct_reset_token?
    session[:reset_token] = nil
    render :reset_password_form
  end

  def get_reset_token_by_email(email)
    User.find_by_email(email).reset_token
  end

  def correct_reset_token?
    @user = User.find_by_email(params[:user_email])
    session[:reset_token] == @user.reset_token
  end

end
