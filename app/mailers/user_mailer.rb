class UserMailer < ActionMailer::Base
  require 'addressable/uri'
  default from: "from@socialthingamajig.com"

  def forgot_email(user)
    @user = user
    @url = Addressable::URI.new(
      :scheme => "http",
      :host => "localhost:3000",
      :path => "/users/reset_password_form",
      :query_values => {
        :reset_token => @user.reset_token,
        :user_email => @user.email
      }
    ).to_s

    mail(to: user.email, subject: 'Forgot Password? Reset Here.')
  end
end

