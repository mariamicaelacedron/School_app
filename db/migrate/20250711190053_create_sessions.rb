class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      
      t.timestamps
    end
  end
end