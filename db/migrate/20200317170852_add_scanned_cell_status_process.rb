class AddScannedCellStatusProcess < ActiveRecord::Migration[6.0]
  def change
    add_column :scanned_cells, :process_status, :integer
  end
end
