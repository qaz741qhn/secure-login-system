class UsersController < ApplicationController

  before_action :signed_up_redirect, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash.now[:notice] = "Welcome to my app #{@user.email}"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy if user == current_user
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def signed_up_redirect
    if current_user
      flash[:notice] = "You are already signed up"
      redirect_to root_path
    end
  end
end