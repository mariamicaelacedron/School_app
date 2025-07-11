module Users
    class SummariesController < ApplicationController
      before_action :authenticate_user!
      before_action :ensure_regular_user!
  
      def index
        @summaries = current_user.summaries_received.order(week_start: :desc)
      end
  
      def show
        @summary = current_user.summaries_received.find(params[:id])
      end
  
      private
  
      def ensure_regular_user!
        redirect_to admin_summaries_path, alert: "Acceso denegado" if current_user.admin?
      end
    end
  end