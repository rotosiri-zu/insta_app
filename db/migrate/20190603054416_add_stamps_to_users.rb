class AddStampsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stamp_true, :boolean, default: true, null: false
  end
end
