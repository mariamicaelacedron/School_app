module Users
    class ProfilesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_user, only: [:show, :edit, :update]
  
      def show
        @latest_summary = current_user.summaries_received.order(week_start: :desc).first
      end
  
      def edit
      end
  
      def update
        # Eliminar el avatar si se marcó la opción de eliminar
        @user.avatar.purge if params[:user][:remove_avatar] == '1'
  
        if @user.update(user_params.except(:remove_avatar))
          redirect_to users_profile_path, notice: 'Perfil actualizado correctamente.'
        else
          render :edit
        end
      end
  
      private
  
      def set_user
        @user = current_user
      end
  
      def user_params
        params.require(:user).permit(:name, :email, :description, :avatar)
      end
    end
  end