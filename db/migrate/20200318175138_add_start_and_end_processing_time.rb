class AddStartAndEndProcessingTime < ActiveRecord::Migration[6.0]
  def change
    add_column :scanning_images, :start_processing_at, :datetime
    add_column :scanning_images, :finish_processing_at, :datetime
  end
end
