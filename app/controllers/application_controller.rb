class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = 'You must be logged in to perform this action'
      redirect_to login_path
    end
  end

  def find_most_liked_article
    article_id_counts = Like.group(:article_id).count
    most_popular_count = article_id_counts.sort_by(&:last).last
    most_popular_article_id = most_popular_count.first
    @most_popular_article = Article.find(most_popular_article_id)
  end

  def find_most_commented_article
    article_id_counts = Comment.group(:article_id).count
    most_commented_count = article_id_counts.sort_by(&:last).last
    most_commented_article_id = most_commented_count.first
    @most_commented_article = Article.find(most_commented_article_id)
  end

end
