class CreateSkillProposals < ActiveRecord::Migration
  def change
    create_table :skill_proposals do |t|
      t.string :name, null: false, uniqueness: true

      t.integer :proposed_by, index: true, null: false
      t.integer :reviewed_by, index: true

      t.timestamps null: false
    end
  end
end
