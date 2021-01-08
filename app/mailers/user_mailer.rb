class UserMailer < ApplicationMailer

  def reminder(user)
    @user = user
    mail(to: @user.email, subject:'test action mailer' )
  end
end
