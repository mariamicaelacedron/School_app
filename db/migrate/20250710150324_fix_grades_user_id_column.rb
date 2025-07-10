class FixGradesUserIdColumn < ActiveRecord::Migration[8.0]
  def up
    # Verificar si la columna student_id existe antes de intentar renombrarla
    if column_exists?(:grades, :student_id)
      # Renombrar la columna
      rename_column :grades, :student_id, :user_id

      # Eliminar la antigua clave foránea
      remove_foreign_key :grades, :users, column: :student_id

      # Agregar la nueva clave foránea
      add_foreign_key :grades, :users, column: :user_id
    end

    # Asegurarse que la columna admin_id hace referencia a users
    unless foreign_key_exists?(:grades, column: :admin_id)
      add_foreign_key :grades, :users, column: :admin_id
    end
  end

  def down
    # Revertir los cambios si es necesario
    if column_exists?(:grades, :user_id)
      rename_column :grades, :user_id, :student_id
      remove_foreign_key :grades, :users, column: :user_id
      add_foreign_key :grades, :users, column: :student_id
    end
  end
end
