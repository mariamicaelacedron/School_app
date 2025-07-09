module Users
  class GradesController < ApplicationController
    before_action :authenticate_user!

    def index
      @grades = current_user.grades_received.includes(:admin, :student)
    end
  end
end