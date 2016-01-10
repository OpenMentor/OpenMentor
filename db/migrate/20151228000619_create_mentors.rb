class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
      t.string :name, null: false
      t.string :email, null: false, uniqueness: true
      t.text :about

      t.timestamps null: false
    end
  end
end
