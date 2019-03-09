class PageController < ApplicationController
  before_action :authorize, only: [:profile, :profile_update]
  before_action :check_login, except: [:profile, :profile_update, :log_out]

  def login_page
    @user = User.new
  end

  def login
    user = User.find_by(email: user_params[:email])
    if user and user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to profile_path, notice: "Log In Success"
    else
      redirect_to login_path, notice: "Login Fail"
    end
  end

  def sign_up_page
    @user = User.new
  end

  def sign_up
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      UserMailer.welcome(@user).deliver_now
      redirect_to profile_path, notice: "User was successfully created."
    else
      render :sign_up_page
    end
  end

  def profile
    # @user = User.find_by(id: session[:user_id])
  end

  def profile_update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Update Success"
    else
      render :profile
    end
  end

  def log_out
    session[:user_id] = nil
    redirect_to login_path
  end

  def forgot_password_page
    @user = User.new
  end

  def forgot_password
    @user = User.find_by(:email => user_params[:email])
    if @user.persisted?
      @user.set_reset_token
      UserMailer.reset_password(@user).deliver_now
      redirect_to login_path, notice: "Reset password mail will send to email!"
    else
      redirect_to forgot_password_path, notice: "Email is not registered!"
    end
  end

  def reset_password_page
    @user = User.find_by(:reset_token => params[:token])
    if @user.blank? || @user.reset_sent_at + 6.hours < Time.now
      redirect_to login_path, notice: "Reset password token expire"
    end
  end

  def reset_password
    @user = User.find_by(:reset_token => params[:token])
    if @user.update(user_params.merge(:reset_token => ""))
      redirect_to login_path, notice: "Reset password Success"
    else
      render :reset_password_page
    end
  end

  private

  def check_login
    @user = User.find_by(id: session[:user_id])
    if @user.present?
      redirect_to profile_path, "Already log in"
    end
  end

  def authorize
    @user = User.find_by(id: session[:user_id])
    unless @user
      redirect_to root_path, notice: "Please log in"
    end
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :email, :password, :password_confirmation)
  end
end
