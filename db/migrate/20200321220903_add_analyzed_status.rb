class AddAnalyzedStatus < ActiveRecord::Migration[6.0]

  def change
    add_column :scanning_images, :analysis_status, :integer
  end

end
