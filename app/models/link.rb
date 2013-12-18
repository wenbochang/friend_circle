class Link < ActiveRecord::Base
  attr_accessible :hyperlink, :post_id

  validates :hyperlink, :post, :presence => true

  belongs_to :post
end
