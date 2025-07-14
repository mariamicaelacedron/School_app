# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      "success" => "success",
      "error" => "danger",
      "alert" => "warning",
      "notice" => "info",
      "danger" => "danger",
      "warning" => "warning"
    }.fetch(flash_type.to_s, flash_type.to_s)
  end
  def attendance_status_class(status)
    case status
    when 'present' then 'bg-success'
    when 'late' then 'bg-warning text-dark'
    when 'absent' then 'bg-danger'
    else 'bg-secondary'
    end
  end

  def status_icon(status)
    case status
    when 'present' then 'bi-check-circle-fill'
    when 'late' then 'bi-clock-fill'
    when 'absent' then 'bi-x-circle-fill'
    else 'bi-question-circle-fill'
    end
  end
end
