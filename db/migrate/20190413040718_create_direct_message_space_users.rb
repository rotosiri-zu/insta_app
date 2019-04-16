class CreateDirectMessageSpaceUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_message_space_users do |t|
      t.integer :direct_message_space_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
