class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    redirect_to root_path, notice: "Can't create user while already signed in" unless signed_in? == false
    @user = User.new
  end

  def create
    redirect_to root_path, notice: "Can't create user while already signed in" unless signed_in? == false
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Loud RoR Labs!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit

  end

  def update

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updates"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page:params[:page])

  end

  def destroy
    unless User.find(params[:id]) == current_user
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    else
      redirect_to users_path, notice: "You can't delete yourself"
    end
  end

  private


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
