class AddProfileFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    # Solo agregar campos que no existan
    add_column :users, :description, :text unless column_exists?(:users, :description)

    # No agregar name si ya existe
    unless column_exists?(:users, :avatar)
      add_column :users, :avatar, :string
    end
  end
end
