class CreateGrades < ActiveRecord::Migration[8.0]
  def change
    create_table :grades do |t|
      t.references :student, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true
      t.float :score
      t.text :comment
      t.string :subject

      t.timestamps
    end
  end
end
