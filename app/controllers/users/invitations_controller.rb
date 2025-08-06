class Users::InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters

    def edit
      resource.name ||= ""
      super
    end

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [ :name, :password, :password_confirmation ])
    end
end
