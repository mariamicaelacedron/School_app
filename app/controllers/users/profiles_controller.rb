module Users
  class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update]
    before_action :authorize_profile_access, only: [:show]
    before_action :ensure_own_profile, only: [:edit, :update]

    def show
      @latest_summary = @user.summaries_received.order(week_start: :desc).first
    end

    def edit
      # La acción edit ahora solo se ejecuta para el usuario actual
    end

    def update
      @user.avatar.purge if params[:user][:remove_avatar] == "1"
      
      if @user.update(user_params.except(:remove_avatar))
        redirect_to users_profile_path(@user), notice: "Perfil actualizado correctamente."
      else
        render :edit
      end
    end

    private

    def set_user
      @user = params[:id] ? User.find(params[:id]) : current_user
    end

    def authorize_profile_access
      unless current_user.admin? || @user == current_user
        redirect_to root_path, alert: "No tienes permiso para acceder a este perfil"
      end
    end

    def ensure_own_profile
      unless @user == current_user
        redirect_to users_profile_path(@user), alert: "Solo puedes editar tu propio perfil"
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :description, :avatar, :remove_avatar)
    end
  end
end