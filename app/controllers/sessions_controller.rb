class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Signed in!"
      redirect_to root_path
    else
      flash[:alert] = "Could not sign in!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:liked] = []
    flash[:notice] = "Signed out!"
    redirect_to root_path
  end
end
