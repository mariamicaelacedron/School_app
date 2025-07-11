class CreateSessionStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :session_students do |t|
      t.references :session, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }
      
      t.timestamps
    end
  end
end