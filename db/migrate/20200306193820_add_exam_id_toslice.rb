class AddExamIdToslice < ActiveRecord::Migration[6.0]
  def change
    add_column :slices, :exam_id, :integer
  end
end
