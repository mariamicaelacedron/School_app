class AddAttendedToSessionStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :session_students, :attended, :boolean, default: false
  end
end
