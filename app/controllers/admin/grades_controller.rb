module Admin
    class GradesController < ApplicationController
      before_action :authenticate_user!
      before_action :ensure_admin!
      
      def index
        @grades = Grade.all.includes(:user, :admin)
      end
  
      def new
        @grade = Grade.new
        @users = User.where(role: 'user') # Removí el where.not para testing
      end
  
      def create
        @grade = Grade.new(grade_params)
        @grade.admin = current_user
  
        if @grade.save
          redirect_to admin_grades_path, notice: 'Calificación creada exitosamente'
        else
          @users = User.where(role: 'user')
          render :new, status: :unprocessable_entity
        end
      end
  
      private
  
      def grade_params
        params.require(:grade).permit(:user_id, :subject, :score, :comment, :student_name)
      end
  
      def ensure_admin!
        unless current_user.admin?
          redirect_to root_path, alert: 'No tienes permisos de administrador'
        end
      end
    end
  end