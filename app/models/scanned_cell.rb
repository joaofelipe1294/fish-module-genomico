class ScannedCell < ApplicationRecord
  belongs_to :scanning_image
  before_validation :set_label
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

  def red_green
    find_image "red"
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

end
