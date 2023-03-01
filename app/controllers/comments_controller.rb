class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to post_path(@post) }
      else
        format.html { redirect_to post_path(@post), status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
