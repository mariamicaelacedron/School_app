module AttendancesHelper
    def attendance_status_class(status)
      case status.to_s
      when "present" then "bg-success"
      when "absent" then "bg-danger"
      when "late" then "bg-warning"
      else "bg-secondary"
      end
    end
end
