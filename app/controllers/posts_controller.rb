class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def new
    @post = Post.new
  end

  def create
      @post = current_user.posts.new(post_params)

      if @post.save
        redirect_to user_posts_path(current_user), notice: 'Post created successfully.'
      else
        flash.now[:alert] = 'Something went wrong.'
        render :new
      end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post deleted successfully .'
    redirect_to user_posts_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
