class CommentsController < ActionController::Base



  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = @current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}", notice: 'Comment created successfully' }
        format.json { render json: @comment, status: :created}
      end


    else
      respond_to do |format|
        format.html { render :new}
        format.json { render json: @comment.errors, status: :unprocessable_entry}
      end
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
