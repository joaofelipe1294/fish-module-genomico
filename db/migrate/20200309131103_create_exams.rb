class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.string :name
      t.string :patient
      t.string :subsample_label
      t.references :fish_slice, null: false
      t.date :start_date
      t.integer :genomico_exam_id

      t.timestamps
    end
  end
end
