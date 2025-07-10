class FixGradesUserRelation < ActiveRecord::Migration[8.0]
  def change
    # Verifica si existe student_id y cámbiala a user_id
    if column_exists?(:grades, :student_id)
      rename_column :grades, :student_id, :user_id
    else
      add_column :grades, :user_id, :integer unless column_exists?(:grades, :user_id)
    end

    # Asegura la clave foránea
    if foreign_key_exists?(:grades, column: :student_id)
      remove_foreign_key :grades, column: :student_id
    end
    
    add_foreign_key :grades, :users, column: :user_id unless foreign_key_exists?(:grades, column: :user_id)
  end
end