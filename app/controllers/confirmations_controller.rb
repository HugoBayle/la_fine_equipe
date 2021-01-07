class ConfirmationsController < Devise::ConfirmationsController

  private
    def after_confirmation_path_for(resource_name, resource)
      sign_in(resource)
      new_profile_path
    end
end
