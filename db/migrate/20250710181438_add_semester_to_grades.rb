class AddSemesterToGrades < ActiveRecord::Migration[6.1]
  def change
    add_column :grades, :semester, :integer, default: 1
  end
end