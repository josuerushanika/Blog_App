class CommentsController < ActionController::Base
   def index
    @user = User.find(params[:id])
    @posts = Post.find(params[:id])
    @comments = Comment.find(params[:comment_id])

    respond_to do |format|
       format.htmlformat.json { render json: @comment}
    end
   end


  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = @current_user

    if @comment.save
      redirect_to user_posts_path
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
