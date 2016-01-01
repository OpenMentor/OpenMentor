class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.belongs_to :mentor
      t.integer :day, null: false
      t.time :start, null: false
      t.time :end, null: false
      t.timestamps null: false
    end
  end
end
