class UpdateHomeImagesFields < ActiveRecord::Migration[8.0]
  def change
    change_column_null :home_images, :image, false
    rename_column :home_images, :title, :caption
    change_column_null :home_images, :caption, false
    add_column :home_images, :active, :boolean, default: true

    add_index :home_images, :position
    add_index :home_images, :active
  end
end
