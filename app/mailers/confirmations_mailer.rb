class ConfirmationsMailer < ApplicationMailer
  def confirmation(user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: 'Email confirmation')
  end
end
