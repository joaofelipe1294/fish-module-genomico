class Scanning < ApplicationRecord
  include ResponsibleReference
  belongs_to :fish_slice
  validates_presence_of :date
  has_many :scanning_images
  after_create_commit :generate_images
  has_many_attached :images

  private

    def generate_images
      puts "----------------------- GENERATE IMAGES --------------------------"
      self.images.each do |image|
        ImageProcessorService.new({image: image, scanning: self}).call
        # puts "PENDEJADA !!!"
      end
      puts "--------------------- END GENERATE IMAGES ------------------------"
    end

end
