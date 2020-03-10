class Scanning < ApplicationRecord
  include ResponsibleReference
  belongs_to :fish_slice
  validates_presence_of :date
  has_many_attached :image
end
