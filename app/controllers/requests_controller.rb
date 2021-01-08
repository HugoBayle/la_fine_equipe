class RequestsController < ApplicationController
  def confirmation_queue
    @user = User.find(params[:user])
    @user.request.last_check = Time.now
    @user.request.save
  end
end
