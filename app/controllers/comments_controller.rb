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
    
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@comment)}_item") }
      format.html { redirect_to post_path(@post) }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
