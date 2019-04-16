class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.integer :direct_message_space_id, null: false
      t.integer :user_id, null: false
      t.string  :message, null: false

      t.timestamps
    end
  end
end
