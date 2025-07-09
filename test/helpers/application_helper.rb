module ApplicationHelper
    def bootstrap_alert_class(flash_type)
      case flash_type.to_sym
      when :notice then 'success'
      when :alert, :error then 'danger'
      else flash_type.to_s
      end
    end
  end