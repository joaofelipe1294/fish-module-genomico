class ScanningImage < ApplicationRecord
  belongs_to :scanning
  validates_presence_of :total_nucleus_found, :valid_nucleus_found
  has_many :scanning_images
  after_create :generate_images

  private

    def generate_images
      self.images.each do |image|
        ImageProcessorService.new(image).call
      end
    end

end
