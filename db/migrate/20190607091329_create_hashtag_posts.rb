class CreateHashtagPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtag_posts do |t|
      t.references :hashtag, index: true, null: false, foreign_key: true
      t.references :post, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
