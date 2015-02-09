class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.text :content, null: false
      t.boolean :complete, default: false

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :posts
  end
end
