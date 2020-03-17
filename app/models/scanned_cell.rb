class ScannedCell < ApplicationRecord
  belongs_to :scanning_image
  before_validation :set_label
  after_create_commit :extract_color_channels_job
  has_many_attached :images
  enum label: {
    positive: 1,
    negative: 0
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

end
