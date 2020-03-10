class Scanning < ApplicationRecord
  include ResponsibleReference
  belongs_to :fish_slice
  validates_presence_of :date
end
