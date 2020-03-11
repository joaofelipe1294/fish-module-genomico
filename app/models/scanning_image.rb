class ScanningImage < ApplicationRecord
  belongs_to :scanning
  validates_presence_of :total_nucleus_found, :valid_nucleus_found
  has_one_attached :original
  has_one_attached :png_image
  has_one_attached :marked_image
end
