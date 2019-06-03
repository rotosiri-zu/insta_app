class CreateFootStamps < ActiveRecord::Migration[5.2]
  def change
    create_table :foot_stamps do |t|
      t.integer :to_user_id, null: false
      t.integer :from_user_id, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
