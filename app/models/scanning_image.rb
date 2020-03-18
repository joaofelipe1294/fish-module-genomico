class ScanningImage < ApplicationRecord
  belongs_to :scanning
  after_create_commit :extract_nucleus_job
  has_one_attached :original
  has_one_attached :png_image
  has_one_attached :marked_image
  has_many :scanned_cells
  accepts_nested_attributes_for :scanned_cells, allow_destroy: true
  before_validation :set_process_status
  enum process_status: {
    waiting_start: 1,
    extracting_nucleus: 2,
    extracting_channels: 3,
    complete: 4
  }

  private

    def set_process_status
      self.process_status = :waiting_start unless self.process_status
    end

    def extract_nucleus_job
      ExtractNucleusJob.perform_later(self)
    end

end
