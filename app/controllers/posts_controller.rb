class PostsController < ApplicationController
  def create
    post = Post.new(post_params.merge(user: current_user))

    if post.save
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
