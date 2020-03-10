class ScanningImage < ApplicationRecord
  belongs_to :scanning
  validates_presence_of :total_nucleus_found, :valid_nucleus_found
end
