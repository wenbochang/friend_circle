class FriendCircle < ActiveRecord::Base
  attr_accessible :user_id

  validates :user_id, :presence => true

  belongs_to :user

  has_many :friend_circle_memberships, :inverse_of => :friend_circle

end
