class GenomicoExamPresenter
  include ActiveModel::Model
  attr_accessor :id, :exam, :patient, :subsample_label, :started_at, :status, :sample_id, :subsample_label
end
