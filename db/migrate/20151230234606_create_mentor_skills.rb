class CreateMentorSkills < ActiveRecord::Migration
  def change
    create_table :mentor_skills do |t|
      t.belongs_to :mentor, null: false
      t.belongs_to :skill, null: false

      t.timestamps null: false
    end
  end
end
