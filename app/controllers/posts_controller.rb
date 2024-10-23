class PostsController < ApplicationController
  def create
    @post = Post.new(post_params.merge(user: current_user))

    if @post.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
