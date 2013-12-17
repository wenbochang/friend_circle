class UserMailer < ActionMailer::Base
  require 'addressable/uri'
  default from: "from@socialthingamajig.com"

  def forgot_email(user)
    @user = user
    # @url = Addressable::URI.new(
    # :host => "localhost:3000",
    # :path => "/users/reset_page",
    # :query_values => {:q => "reset_token"}
    # ).to_s
    @url = users_reset_page_url + "?reset_token=#{@user.reset_token}"
    mail(to: user.email, subject: 'Forgot Password? Reset Here.')
  end
end

