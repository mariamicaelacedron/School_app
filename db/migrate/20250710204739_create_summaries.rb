class CreateSummaries < ActiveRecord::Migration[8.0]
  def change
    create_table :summaries do |t|
      t.references :user, null: false, foreign_key: true
      t.date :week_start
      t.text :activities
      t.boolean :participated
      t.text :remarks

      t.timestamps
    end
  end
end
