class CommentsController < ApplicationController
  before_action :require_user
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params[:comment].permit(:name, :comment))
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment posted successfully!"
      redirect_to article_path(@article)
    else
      flash.now[:notice] = 'Error while sending message!'
    end
  end

  def destroy
    @article= Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

end
