# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "No tienes permisos para acceder a esta sección"
    end
  end
end