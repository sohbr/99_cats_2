class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:create, :new]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params[:username],user_params[:password])


    if user.nil?
      flash[:errors] = ["Incorrect username and/or password"]
      render :new
    else
      login_user!(user)
      redirect_to cats_url
    end

  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
