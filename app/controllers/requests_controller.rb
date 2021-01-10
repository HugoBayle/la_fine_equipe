class RequestsController < ApplicationController
  def confirmation_queue
    @user = User.find(params[:user])
  end
end
