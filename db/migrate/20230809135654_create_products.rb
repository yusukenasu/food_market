class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :manufacturer
      t.integer :price
      t.string :category
      t.string :description
      t.integer :point_of_reasonability
      t.integer :point_of_uniqueness
      t.integer :point_of_taste
      t.integer :point_of_repeatability
      t.integer :point_of_design

      t.timestamps
    end
  end
end
