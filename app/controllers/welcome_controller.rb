class WelcomeController < ApplicationController
  def home
    @popular = find_most_popular_article
  end

  def about

  end
end
