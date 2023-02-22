class FindPosts
  attr_reader :posts

  def initialize(posts = initial_scope)
    @posts = posts
  end

  def call(params = {})
    scoped = posts
    scoped = filter_by_user_id(scoped, params[:user_id])
    sort(scoped)
  end

  private

    def initial_scope
      Post.with_attached_image
    end

    def filter_by_user_id(scoped, user_id) 
      return scoped unless user_id.present?

      scoped.where(user_id: user_id)
    end

    def sort(scoped)
      scoped.order(created_at: :desc)
    end
end