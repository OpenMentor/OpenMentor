class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id, null: false
      t.text :body, null: false
      t.datetime :sent_at, null: false
      t.belongs_to :conversation

      t.timestamps null: false
    end
  end
end
