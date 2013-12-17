class User < ActiveRecord::Base
  attr_accessible :email, :password, :reset_token

  before_validation :gen_token

  validates :email, :password_digest, :token, :presence => true

  def reset_session_token
    self.token = SecureRandom.urlsafe_base64
    self.save!
    self.token
  end

  def password=(secret)
    self.password_digest = BCrypt::Password.create(secret)
  end

  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

  def find_by_credentials(params)
    User.find_by_email_and_password_digest(
      params[:email],
      params[:password_digest]
    )
  end

  def gen_token
    self.token = SecureRandom.urlsafe_base64 if self.token.nil?
  end

end
