class Post < ActiveRecord::Base
  attr_accessible :body, :user_id

  validates :body, :user, :presence => true

  belongs_to :user
  has_many :links, :inverse_of => :post
end
