class Slice < ApplicationRecord
  validates_presence_of :responsible_id, :responsible_login, :date, :subsample_id, :subsample_label, :probe
  enum probe: {
    bcr_abl: 1,
  }
end
