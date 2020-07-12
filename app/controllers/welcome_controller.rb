class WelcomeController < ApplicationController
  def home
    @article_most_liked = find_most_liked_article
    @article_most_commented = find_most_commented_article
  end

  def about

  end
end
