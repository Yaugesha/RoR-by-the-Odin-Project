class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @author = current_user ? User.find(@post.user_id).username : "Top secret"
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    @post.user_id = current_user.id

    if @post.save
      flash[:success] = "Great! Your article has been created!"
      redirect_to @post
    else
      flash.now[:error] = "Rats! Fix your mistakes, please."
      render :new, status: :unprocessable_entity
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
