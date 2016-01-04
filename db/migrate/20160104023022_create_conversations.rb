class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.text :subject, null: false
      t.timestamps null: false
    end
  end
end
