class CreateHorses < ActiveRecord::Migration
  def change
    create_table :horses do |t|
      t.decimal :height
      t.string :name
      t.string :color

      t.timestamps null: false
    end
  end
end
