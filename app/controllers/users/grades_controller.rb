module Users
  class GradesController < ApplicationController
    before_action :authenticate_user!

    def index
      @semesters = {
        1 => current_user.grades_received.where(semester: 1).includes(:admin).order(created_at: :desc),
        2 => current_user.grades_received.where(semester: 2).includes(:admin).order(created_at: :desc),
        3 => current_user.grades_received.where(semester: 3).includes(:admin).order(created_at: :desc)
      }
    end
  end
end
