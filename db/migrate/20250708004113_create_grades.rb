class CreateGrades < ActiveRecord::Migration[8.0]
  def change
    create_table :grades do |t|
      t.references :user, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: { to_table: :users }
      t.string :student_name
      t.string :subject
      t.float :score
      t.text :comment

      t.timestamps
    end
  end
end