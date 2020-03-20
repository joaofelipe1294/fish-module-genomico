class ScannedCell < ApplicationRecord
  belongs_to :scanning_image
  before_validation :set_label
  before_validation :set_process_status
  has_one_attached :rgb
  has_one_attached :blue
  has_one_attached :red
  has_one_attached :green
  has_one_attached :blue_green
  has_one_attached :blue_red
  has_one_attached :green_red
  paginates_per 45
  enum label: {
    positive: 1,
    negative: 0
  }
  enum process_status: {
    waiting_start: 1,
    processing: 2,
    complete: 3
  }

  def blue_path
    ActiveStorage::Blob.service.send(:path_for, self.blue.key)
  end

  def green_path
    ActiveStorage::Blob.service.send(:path_for, self.green.key)
  end

  def red_path
    ActiveStorage::Blob.service.send(:path_for, self.red.key)
  end

  def blue_green_path
    ActiveStorage::Blob.service.send(:path_for, self.blue_green.key)
  end


  def blue_red_path
    ActiveStorage::Blob.service.send(:path_for, self.blue_red.key)
  end

  def green_red_path
    ActiveStorage::Blob.service.send(:path_for, self.green_red.key)
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

    # def extract_color_channels_job
    #   NucleusChannelExtractionJob.perform_later(self)
    # end

    # def check_if_all_nucleus_are_processed
    #   scanning_image = self.scanning_image
    #   if scanning_image.scanned_cells.complete.size > scanning_image.scanned_cells.size * 0.75
    #     scanning_image.update(process_status: :complete, finish_processing_at: DateTime.current)
    #   end
    # end

end
