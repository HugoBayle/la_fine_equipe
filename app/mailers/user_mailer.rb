class UserMailer < ApplicationMailer

  def reminder(user)
    @user = user
    mail(to: @user.email, subject:'Relance inscription La Fine Equipe' )
  end
end
