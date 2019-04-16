class CreateDirectMessageSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_message_spaces do |t|

      t.timestamps
    end
  end
end
