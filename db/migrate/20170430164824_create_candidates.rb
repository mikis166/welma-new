class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.references :job, index: true, foreign_key: true
      t.references :profile, index: true, foreign_key: true
      t.string :description
      t.attachment :cv

      t.timestamps null: false
    end
  end
end
