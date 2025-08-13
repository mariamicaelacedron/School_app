module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_user, only: [ :resend_invitation, :destroy ]

    def index
      @users = User.all.order(created_at: :desc)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.invite!(user_params, current_user) do |u|
        u.skip_invitation = true
      end

      if @user.persisted?
        @user.deliver_invitation
        redirect_to admin_users_path, notice: "Invitación enviada a #{@user.email}"
      else
        render :new, alert: "Error al enviar la invitación"
      end
    end

    def resend_invitation
      @user.invite!(current_user)
      redirect_to admin_users_path, notice: "Invitación reenviada a #{@user.email}"
    end
    def destroy
      if @user == current_user
        redirect_to admin_users_path, alert: "No puedes eliminarte a ti mismo"
      elsif @user.destroy
        redirect_to admin_users_path, notice: "Usuario eliminado correctamente"
      else
        redirect_to admin_users_path, alert: "No se pudo eliminar el usuario: #{@user.errors.full_messages.to_sentence}"
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :role)
    end

    def require_admin
      unless current_user.admin?
        redirect_to root_path, alert: "No tienes permisos para acceder a esta sección"
      end
    end
  end
end
