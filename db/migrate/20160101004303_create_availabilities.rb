class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.belongs_to :mentor
      t.datetime :start, null: false
      t.integer :duration, null: false, default: 1
      t.timestamps null: false
    end
  end
end
