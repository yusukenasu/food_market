class RenamePointOfUniquenessColumnToProducts < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :point_of_uniqueness, :point_of_impression
  end
end
