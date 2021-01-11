class RequestsController < ApplicationController
  before_action :authenticate_user!, except: :confirmation_queue

  def confirmation_queue
    @user = User.find(params[:user])
    @user.request.date_mail_sent = nil
    @user.request.save
  end

    def queue
    @user = current_user
  end
end
