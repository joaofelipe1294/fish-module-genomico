class ScanningImage < ApplicationRecord
  belongs_to :scanning
  has_one_attached :original
  has_one_attached :png_image
  has_one_attached :marked_image
  has_many :scanned_cells
  accepts_nested_attributes_for :scanned_cells, allow_destroy: true
  enum process_status: {
    waiting_start: 1,
    extracting_nucleus: 2,
    complete: 3
  }
end
