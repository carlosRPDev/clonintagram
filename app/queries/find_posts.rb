class FindPosts
  attr_reader :posts

  def initialize(posts = initial_scope)
    @posts = posts
  end

  def call(params = {})
    scoped = posts
    scoped = filter_by_username(scoped, params[:username])
    sort(scoped)
  end

  private

    def initial_scope
      Post.with_attached_image
    end

    def filter_by_username(scoped, username) 
      return scoped unless username.present?

      scoped.where(username: username)
    end

    def sort(scoped)
      scoped.order(created_at: :desc)
    end
end