class CreateScannedCells < ActiveRecord::Migration[6.0]
  def change
    create_table :scanned_cells do |t|
      t.references :scanning_image, null: false, foreign_key: true
      t.integer :label

      t.timestamps
    end
  end
end
