module Users
  class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [ :show, :edit, :update ]
    before_action :authorize_profile_access, only: [ :show ]
    before_action :ensure_own_profile, only: [ :edit, :update ]

    def show
      @latest_summary = @user.summaries_received.order(week_start: :desc).first
    end

    def edit
    end
    def update
      if params[:user] && params[:user][:avatar] && params[:user][:avatar].size > 5.megabytes
        @user.errors.add(:avatar, "es demasiado grande (máximo 5MB)")
        render :edit, status: :unprocessable_entity and return
      end
    
      if params.dig(:user, :remove_avatar) == "1"
        @user.avatar.purge_later if @user.avatar.attached?
      end
    
      if @user.update(user_params.except(:remove_avatar))
        redirect_to users_profile_path(@user), notice: "Perfil actualizado correctamente."
      else
        render :edit, status: :unprocessable_entity
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
