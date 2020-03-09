class AddExamIdToslice < ActiveRecord::Migration[6.0]
  def change
    add_column :fish_slices, :genomico_exam_id, :integer
  end
end
