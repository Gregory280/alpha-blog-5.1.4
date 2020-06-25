class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welecome to the Alpha BLog, #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
   
    if @user.update(user_params)
      flash[:notice] = "User was update successfully!"
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end
  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
