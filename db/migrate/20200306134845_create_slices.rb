class CreateSlices < ActiveRecord::Migration[6.0]
  def change
    create_table :slices do |t|
      t.integer :responsible_id
      t.string :responsible_login
      t.date :date
      t.integer :subsample_id
      t.string :subsample_label
      t.integer :probe

      t.timestamps
    end
  end
end
