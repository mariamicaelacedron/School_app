module Users
  class CoursesController < ApplicationController
    before_action :authenticate_user!

    def index
      @courses = current_user.courses.includes(:attendances).order(name: :asc)
      @course_stats = calculate_courses_stats
    end

    def show
      @course = current_user.courses.includes(:attendances).find_by(id: params[:id])
      
      unless @course
        redirect_to users_courses_path, alert: 'Curso no encontrado o no tienes acceso'
        return
      end

      load_attendance_data
      calculate_attendance_stats
    end

    private

    def calculate_courses_stats
      current_user.courses.each_with_object({}) do |course, stats|
        attendances = course.attendances.where(user: current_user)
        next stats[course.id] = empty_stats unless attendances.any?

        present = attendances.where(status: 'present').count
        late = attendances.where(status: 'late').count
        total = attendances.count

        stats[course.id] = {
          present: present,
          late: late,
          absent: attendances.where(status: 'absent').count,
          total: total,
          percentage: calculate_percentage(present + late, total)
        }
      end
    end

    def load_attendance_data
      @attendances = @course.attendances
                           .where(user: current_user)
                           .order(date: :desc)
                           .group_by(&:date)

      @recent_attendances = @course.attendances
                                  .where(user: current_user)
                                  .order(date: :desc)
                                  .limit(5)
    end

    def calculate_attendance_stats
      attendances = @course.attendances.where(user: current_user)

      if attendances.any?
        present = attendances.where(status: 'present').count
        late = attendances.where(status: 'late').count
        
        @attendance_stats = {
          present: present,
          late: late,
          absent: attendances.where(status: 'absent').count,
          total: attendances.count,
          percentage: calculate_percentage(present + late, attendances.count)
        }
      else
        @attendance_stats = empty_stats
      end
    end

    def calculate_percentage(value, total)
      total.positive? ? (value.to_f / total * 100).round : 0
    end

    def empty_stats
      { present: 0, late: 0, absent: 0, total: 0, percentage: 0 }
    end
  end
end