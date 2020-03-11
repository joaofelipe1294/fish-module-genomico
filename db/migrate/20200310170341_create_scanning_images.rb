class CreateScanningImages < ActiveRecord::Migration[6.0]
  def change
    create_table :scanning_images do |t|
      t.references :scanning, null: false, foreign_key: true
      t.integer :total_nucleus_found
      t.integer :valid_nucleus_found

      t.timestamps
    end
  end
end
