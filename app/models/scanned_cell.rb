class ScannedCell < ApplicationRecord
  belongs_to :scanning_image
  before_validation :set_label
  after_create_commit :extract_color_channels_job
  has_many_attached :images
  before_validation :set_process_status
  after_update :check_if_all_nucleus_are_processed
  enum label: {
    positive: 1,
    negative: 0
  }
  enum process_status: {
    waiting_start: 1,
    processing: 2,
    complete: 3
  }

  def rgb
    find_image "nucleus"
  end

  def blue
    find_image "blue_nucleus"
  end

  def green
    find_image "green_nucleus"
  end

  def red
    find_image "red_nucleus"
  end

  def green_red
    find_image "green_red_nucleus"
  end

  def blue_green
    find_image "blue_green_nucleus"
  end

  def blue_red
    find_image "blue_red_nucleus"
  end

  private

    def set_label
      self.label = :positive unless self.label
    end

    def set_process_status
      self.process_status = :waiting_start unless self.process_status
    end

    def find_image channel
      channel_image = nil
      self.images.each do |image|
        channel_image = image if image.filename.to_s == "#{channel}.png"
      end
      channel_image
    end

    def extract_color_channels_job
      NucleusChannelExtractionJob.perform_later(self)
    end

    def check_if_all_nucleus_are_processed
      scanning_image = self.scanning_image
      if scanning_image.scanned_cells.complete.size > scanning_image.scanned_cells.size * 0.75
        scanning_image.update(process_status: :complete, finish_processing_at: DateTime.current)
      end
    end

end
