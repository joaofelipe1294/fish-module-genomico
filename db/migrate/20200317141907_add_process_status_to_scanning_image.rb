class AddProcessStatusToScanningImage < ActiveRecord::Migration[6.0]
  def change
    add_column :scanning_images, :process_status, :integer
  end
end
