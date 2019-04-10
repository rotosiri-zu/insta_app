class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :user_name, :string
    add_column :users, :website, :string
    add_column :users, :bio, :text
    add_column :users, :phone_number, :string
    add_column :users, :sex, :string
  end
end
