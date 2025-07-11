module Admin
  class CoursesController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_course, only: [:show, :edit, :update, :destroy, :take_attendance] 
    
    def index
      @courses = Course.all
    end
    
    def new
      @course = Course.new
      @users = User.where(role: :user).order(:email)
    end
    
    def edit
      @users = User.where(role: :user).order(:email)
    end
    def create
      @course = Course.new(course_params.except(:user_ids))
      @users = User.where(role: :user)
    
      if @course.save
        if params[:course][:user_ids].present?
          user_ids = params[:course][:user_ids].reject(&:blank?).map(&:to_i)
          @course.user_ids = user_ids
        end
        redirect_to admin_courses_path, notice: 'Curso creado exitosamente.'
      else
        render :new
      end
    end
    
    def update
      if @course.update(course_params)
        @course.course_users.destroy_all
        if params[:course][:user_ids].present?
          params[:course][:user_ids].each do |user_id|
            @course.course_users.create(user_id: user_id) unless user_id.blank?
          end
        end
        redirect_to admin_course_path(@course), notice: 'Curso actualizado exitosamente.'
      else
        render :edit
      end
    end
    
    def show
      @attendances = @course.attendances
                           .includes(:user)
                           .order(date: :desc)
                           .group_by { |a| a.date } # Agrupa por la fecha directamente
    end
    def take_attendance
      @date = params[:date] || Date.today
      @users = @course.users.order(:email)
    
      if request.post?
        # Verifica primero si hay datos de asistencia
        if params[:attendance].blank?
          flash[:alert] = "No se recibieron datos de asistencia"
          render :take_attendance and return
        end
    
        begin
          ActiveRecord::Base.transaction do
            # Elimina asistencias existentes para esta fecha
            @course.attendances.where(date: @date).delete_all
            
            # Itera solo si params[:attendance] existe
            params[:attendance].each do |user_id, status|
              next if user_id.blank? || status.blank?
              
              @course.attendances.create!(
                user_id: user_id,
                date: @date,
                status: status
              )
            end
          end
          
          redirect_to admin_course_path(@course), notice: 'Asistencia registrada exitosamente.'
        rescue ActiveRecord::RecordInvalid => e
          flash.now[:alert] = "Error al registrar asistencia: #{e.message}"
          render :take_attendance
        end
      end
    end

    def destroy
      @course.destroy
      redirect_to admin_courses_path, notice: 'Curso eliminado exitosamente.'
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_course_path(@course), alert: "No se pudo eliminar el curso: #{e.message}"
    end
    
    private
    
    def set_course
      @course = Course.find(params[:id])
    end
    
    def course_params
      params.require(:course).permit(:name, user_ids: [])
    end
    
    def authenticate_admin!
      unless current_user&.admin?
        redirect_to root_path, alert: 'No tienes permiso para acceder a esta sección.'
      end
    end
  end
end