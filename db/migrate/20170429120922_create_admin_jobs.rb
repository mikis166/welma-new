class CreateAdminJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|

      t.string :title, null: false
      t.text :description, null: false
      t.integer :salary
      t.string :contact
      t.string :kind
      t.string :category
      t.string :company

      t.timestamps null: false
    end
  end
end
