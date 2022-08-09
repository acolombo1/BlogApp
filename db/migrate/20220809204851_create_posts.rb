class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.timestamps
      t.integer :comments_counter
      t.integer :likes_counter
    end
    add_reference(:posts, :author, foreign_key: { to_table: :users })
  end
end
