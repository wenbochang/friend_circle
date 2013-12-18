class PostsController < ApplicationController

  def post_link
    @post = current_user.posts.new(params[:post][:body])

    params[:post][:links].each do |link|
      @post.links.build(:hyperlink => link.last)
    end

    if @post.save
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      render "/users/show"
    end

  end
end
