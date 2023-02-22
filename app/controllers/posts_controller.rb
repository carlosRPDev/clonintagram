class PostsController < ApplicationController
  def index
    @pagy, @posts = pagy_countless(FindPosts.new.call(post_params_index).load_async, items: 12)
  end

  def show
    post
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    post
  end

  def update

    if post.update(post_params)
      redirect_to posts_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post.destroy

    redirect_to posts_path, notice: t('.destroyed'), status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:description, :image)
  end

  def post_params_index
    params.permit(:username)
  end

  def post
    @post = Post.find(params[:id])
  end
end