class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :permalink
      t.text :markdown
      t.text :html
      t.string :tags
      t.references :user, index: true, foreign_key: true
      t.timestamp :published_at

      t.timestamps null: false
    end
  end
end
