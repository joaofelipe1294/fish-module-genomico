class Scanning < ApplicationRecord
  include ResponsibleReference
  belongs_to :fish_slice
  validates_presence_of :date
  has_many :scanning_images
  after_create_commit :generate_images
  has_many_attached :images
  enum process_status: {
    waiting_start: 1,
    processing_image: 2,
    processing_nucleuses: 3,
    processed: 4
  }

  def valid_nucleus
    total = 0
    self.scanning_images.each { |image| total += image.valid_nucleus_found }
    total
  end

  private

    def generate_images
      self.images.each do |image|
        ImageProcessorService.new({image: image, scanning: self}).call
      end
    end

end
