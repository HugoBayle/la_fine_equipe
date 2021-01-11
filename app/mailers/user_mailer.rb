class UserMailer < ApplicationMailer

  def reminder(user)
    @user = user
    mail(to: @user.email, subject:'Relance inscription La Fine Équipe' )
  end

  def welcome(user)
    @user = user
    mail(to: @user.email, subject:"La Fine Équipe - l'attente est terminée" )
  end
end
