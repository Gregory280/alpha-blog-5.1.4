class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

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
    @user = set_user
    @articles = @user.articles.paginate(page: params[:page], per_page: 4)
    @likes = count_articles_likes(@user)
    @comments = count_articles_comments(@user)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = 'Account and articles succesfully deleted'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = 'You can only edit or delete your own profile'
      redirect_to @user
    end
  end

  def count_articles_likes(user)
    user_articles = user.articles
    count_likes=0
    user_articles.each do |article|
      count_likes = count_likes + article.likes.count
    end
    @likes = count_likes
  end

  def count_articles_comments(user)
    user_articles = user.articles
    count_comments = 0
    user_articles.each do |article|
      count_comments = count_comments + article.comments.count
    end
    @comments = count_comments
  end

end
