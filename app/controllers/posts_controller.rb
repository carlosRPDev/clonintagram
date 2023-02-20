class PostsController < ApplicationController
  def index
    @posts = Post.all.with_attached_image.order(created_at: :desc)

    @pagy, @posts = pagy_countless(@posts, items: 12)
  end

  def show
    post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

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

  def post
    @post = Post.find(params[:id])
  end
end