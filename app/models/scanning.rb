class Scanning < ApplicationRecord
  include ResponsibleReference
  belongs_to :fish_slice
  validates_presence_of :date
  has_many :scanning_images
  after_create_commit :generate_images
  has_many_attached :images
  before_validation :set_initial_status
  enum process_status: {
    waiting_start: 1,
    processing: 2,
    complete: 3
  }

  def valid_nucleus
    return "<span class='text-info'>Processando</span> <span class='text-info fa fa-spinner'></span>".html_safe unless self.complete?
    total = 0
    self.scanning_images.each { |image| total += image.valid_nucleus_found }
    "Núcleos válidos: #{total}"
  end

  private

    def generate_images
      self.images.each do |image|
        ConvertAndMarkImageJob.perform_later({image: image, scanning: self})
      end
    end

    def set_initial_status
      self.process_status = :waiting_start unless self.process_status
    end

end
