module ApplicationHelper
    def bootstrap_class_for(flash_type)
      {
        "success" => "success",
        "error" => "danger",
        "alert" => "warning",
        "notice" => "info",
        "danger" => "danger",
        "warning" => "warning"
      }[flash_type.to_s] || flash_type.to_s
    end
  end