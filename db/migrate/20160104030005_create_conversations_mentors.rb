class CreateConversationsMentors < ActiveRecord::Migration
  def change
    create_table :conversations_mentors do |t|
      t.belongs_to :mentor, index: true
      t.belongs_to :conversation, index: true

      t.timestamps null: false
    end
  end
end
