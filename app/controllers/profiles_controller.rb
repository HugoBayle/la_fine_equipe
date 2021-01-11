class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to queue_path
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :phone_number, :bio)
  end
end
