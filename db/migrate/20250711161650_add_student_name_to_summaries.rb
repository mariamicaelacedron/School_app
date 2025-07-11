class AddStudentNameToSummaries < ActiveRecord::Migration[8.0]
  def change
    add_column :summaries, :student_name, :string
  end
end
