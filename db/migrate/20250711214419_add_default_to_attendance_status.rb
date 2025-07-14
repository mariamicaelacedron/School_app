class AddDefaultToAttendanceStatus < ActiveRecord::Migration[8.0]
  def change
    change_column_default :attendances, :status, from: nil, to: 'present'
  end
end
