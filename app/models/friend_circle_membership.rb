class FriendCircleMembership < ActiveRecord::Base
  attr_accessible :user_id, :friend_circle_id

  validates :user_id, :friend_circle, :presence => true

  belongs_to :friend_circle

end
