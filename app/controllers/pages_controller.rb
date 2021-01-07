class PagesController < ApplicationController
    before_action :authenticate_user!, except: :home

  def home
  end

  def queue
    @user = current_user
  end
end
