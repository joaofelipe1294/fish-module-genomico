class Exam < ApplicationRecord
  belongs_to :fish_slice, class_name: "Slice"
  validates_presence_of :name, :patient, :start_date, :genomico_exam_id, :subsample_label
end
