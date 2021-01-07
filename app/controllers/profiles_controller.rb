class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    @profile.save
    redirect_to queue_path
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :phone_number, :bio)
  end
end
