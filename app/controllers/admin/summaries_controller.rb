module Admin
  class SummariesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!
    before_action :set_summary, only: %i[show edit update destroy]

    def index
      @summaries = Summary.order(week_start: :desc).includes(:user)
      if params[:search].present?
        @summaries = @summaries.joins(:user).where(
          "users.name LIKE :search OR users.email LIKE :search", 
          search: "%#{params[:search]}%"
        )
      end
    end

    def new
      @summary = Summary.new
      @users = User.where(role: "user")
    end

    def create
      @summary = Summary.new(summary_params)
      @summary.user_id = params[:summary][:user_id]
      # Asignamos automáticamente el nombre del perfil
      @summary.student_name = @summary.user.name if @summary.user

      if @summary.save
        redirect_to admin_summary_path(@summary), notice: "Resumen creado correctamente"
      else
        @users = User.where(role: "user")
        render :new
      end
    end

    def show; end

    def edit
      @users = User.where(role: "user")
    end

    def update
      # Mantenemos el nombre del perfil actualizado
      @summary.student_name = @summary.user.name
      
      if @summary.update(summary_params)
        redirect_to admin_summary_path(@summary), notice: "Resumen actualizado"
      else
        @users = User.where(role: "user")
        render :edit
      end
    end

    def destroy
      @summary.destroy
      redirect_to admin_summaries_path, notice: "Resumen eliminado"
    end

    private

    def set_summary
      @summary = Summary.find(params[:id])
    end

    def ensure_admin!
      redirect_to root_path, alert: "Acceso denegado" unless current_user.admin?
    end

    def summary_params
      params.require(:summary).permit(
        :user_id,
        :week_start,
        :activities,
        :participated,
        :remarks
        # Removemos :student_name de los parámetros permitidos
      )
    end
  end
end