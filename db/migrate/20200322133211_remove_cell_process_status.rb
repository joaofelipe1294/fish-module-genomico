class RemoveCellProcessStatus < ActiveRecord::Migration[6.0]
  def change
    remove_column :scanned_cells, :process_status
  end
end
