class UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.author = current_user

    if @post.save
      redirect_to "/users/#{current_user.id}/posts", notice: 'Post created Successfully'
    else
      render :new, notice: 'Post not created'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
