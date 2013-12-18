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



    # memberships = []
    # params[:circle][:user_ids].each do |member_id|
    #   memberships << Membership.new(:user_id => member_id)
    # end
    #
    # Circle.transaction do
    #   @circle.save!
    #   memberships.each { |m| m.circle_id = @circle_id; m.save! }
    # end
  end

  def show
    @circle = FriendCircle.find_by_id(params[:id])
    render :show
  end


end
