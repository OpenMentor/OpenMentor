class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.belongs_to :mentor
      t.integer :day, null: false
      t.integer :start_hour, null: false
      t.integer :end_hour, null: false
      t.timestamps null: false
    end
  end
end
