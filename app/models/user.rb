class User < ActiveRecord::Base
  attr_accessible :email, :password, :reset_token

  before_validation :gen_session_token

  validates :email, :password_digest, :token, :presence => true

  has_many :friend_circles
  has_many :posts

  def self.find_by_credentials(params)
    user = User.find_by_email(params[:email])
    user if user && user.is_password?(params[:password])
  end

  def reset_session_token
    self.token = SecureRandom.urlsafe_base64
    self.save!
    self.token
  end

  def password=(secret)
    self.password_digest = BCrypt::Password.create(secret) unless secret.blank?
  end

  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

  def gen_session_token
    self.token = SecureRandom.urlsafe_base64 if self.token.nil?
  end

end
