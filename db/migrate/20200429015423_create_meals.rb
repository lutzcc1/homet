class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :address
      t.integer :min_eaters
      t.integer :max_eaters
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
