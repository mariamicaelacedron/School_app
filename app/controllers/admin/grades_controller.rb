module Admin
  class GradesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!
    before_action :set_grade, only: [:show, :edit, :update, :destroy]
    
    def index
      @users = User.joins(:grades).where(role: "user").distinct
      if params[:search].present?
        @users = @users.joins(:grades).where("grades.student_name LIKE ?", "%#{params[:search]}%")
      end
    end

    def new
      @grade = Grade.new(user_id: params[:user_id], semester: 1)
      @users = User.where(role: "user")
    end

    def show
      @student = @grade.user
      @semesters = {
        1 => @student.grades_received.where(semester: 1).order(created_at: :desc),
        2 => @student.grades_received.where(semester: 2).order(created_at: :desc),
        3 => @student.grades_received.where(semester: 3).order(created_at: :desc)
      }
      @current_semester = params[:semester] || 1
    end
    
    def create
      @grade = Grade.new(grade_params)
      @grade.admin = current_user
      @grade.student_name ||= @grade.user.name if @grade.user
      
      if @grade.save
        redirect_to admin_grade_path(@grade, semester: grade_params[:semester]), notice: "Calificación creada exitosamente"
      else
        @users = User.where(role: "user")
        render :new
      end
    end
    
    def update
      if @grade.update(grade_params)
        redirect_to admin_grade_path(@grade, semester: grade_params[:semester]), notice: "Calificación actualizada exitosamente"
      else
        @users = User.where(role: "user")
        render :edit
      end
    end

    def edit
      @users = User.where(role: "user")
    end


    def destroy
      @grade.destroy
      redirect_to admin_grades_path, notice: "Calificación eliminada exitosamente"
    end


    private
    
    def set_grade
      @grade = Grade.find(params[:id])
    end

    def grade_params
      params.require(:grade).permit(:user_id, :subject, :score, :comment, :student_name, :semester)
    end

    def ensure_admin!
      unless current_user.admin?
        redirect_to root_path, alert: "No tienes permisos de administrador"
      end
    end
  end
end