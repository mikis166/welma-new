class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.boolean :someone_offline?, default: false, null: false
      t.integer :offline_party_id
      t.boolean :add_recipient_to_session?, default: true, null: false
      t.integer :id_to_add_to_session
      t.text    :window_was_closed_for, array: true, default: []
      t.text    :new_messages_available_for, array: true, default: []

      t.timestamps
    end
    add_index :conversations, :recipient_id
    add_index :conversations, :sender_id
    add_index :conversations, [:recipient_id, :sender_id], unique: true
  end
end
