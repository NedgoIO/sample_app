class SessionsController < ApplicationController
  def new
    render 'new'

  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      sign_in user
      flash[:success] = "Welcome back!"
      redirect_back_or user

    else
      flash.now[:error] = 'Invalid Email/password combination'
      render 'new'
    end

  end

  def destroy
    sign_out
    redirect_to root_path

  end
end
