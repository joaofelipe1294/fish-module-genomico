class CreateScannings < ActiveRecord::Migration[6.0]
  def change
    create_table :scannings do |t|
      t.references :fish_slice, null: false, foreign_key: true
      t.integer :responsible_id
      t.string :responsible_login

      t.timestamps
    end
  end
end
