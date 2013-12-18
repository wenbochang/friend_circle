class FriendCirclesController < ApplicationController

  def new
  end

  def create
    @circle = current_user.friend_circles.new

    params[:circle][:user_ids].each do |user_id|
      @circle.friend_circle_memberships.build(
        :user_id => user_id,
      )
    end

    if @circle.save
      redirect_to "/friend_circles/#{@circle.id}"
    else
      flash.now[:errors] = @circle.errors.full_messages
      render :new
    end
  end

  def show
    @circle = FriendCircle.find_by_id(params[:id])
    render :show
  end


end
