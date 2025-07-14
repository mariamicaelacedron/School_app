class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      redirect_to admin_grades_path
    else
      @grades = current_user.grades
    end
  end
end
