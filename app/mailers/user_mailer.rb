class UserMailer < ApplicationMailer

  default from: 'notifications@rottenmangoes.com'

  def account_deleted_email(user)
    @user = user
    @url = "http://rottenmangoes.com"
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
