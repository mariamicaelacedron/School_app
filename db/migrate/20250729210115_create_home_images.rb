class CreateHomeImages < ActiveRecord::Migration[8.0]
  def change
    create_table :home_images do |t|
      t.string :image
      t.string :title
      t.text :description
      t.integer :position

      t.timestamps
    end
  end
end
