class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author_id: current_user.id)

    if @like.save
      flash[:success] = 'Liked'
    else
      flash[:error] = 'Failed to like'
    end
    redirect_to user_posts_path(@user)
  end
end
