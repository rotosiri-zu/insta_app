class AddCheckedToDirectMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :direct_messages, :checked, :boolean, default: false, null: false
  end
end
