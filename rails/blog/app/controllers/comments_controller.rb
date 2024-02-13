class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @commnet = @article.comments.create(comment_parametrs)

    flash[:success] = "Great! Your comment has been created!"
    redirect_to article_path(@article)
  end

  private

    def comment_parametrs
      params.require(:comment).permit(:commenter, :body)
    end
end
