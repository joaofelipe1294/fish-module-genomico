class ScannedCell < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :scanning_image
  before_validation :set_label
  has_one_attached :rgb
  has_one_attached :blue
  has_one_attached :red
  has_one_attached :green
  has_one_attached :blue_green
  has_one_attached :blue_red
  has_one_attached :green_red
  has_one_attached :treated
  paginates_per 45
  enum label: {
    positive: 1,
    negative: 0
  }

  def blue_path
    get_attached_path self.blue
  end

  def green_path
    get_attached_path self.green
  end

  def red_path
    get_attached_path self.red
  end

  def blue_green_path
    get_attached_path self.blue_green
  end

  def blue_red_path
    get_attached_path self.blue_red
  end

  def green_red_path
    get_attached_path self.green_red
  end

  def rgb_path
    get_attached_path self.rgb
  end

  def treated_path
    get_attached_path self.treated
  end

  private

    def set_label
      self.label = :positive unless self.label
    end

    def get_attached_path attachment
      rails_blob_path(attachment, disposition: "attachment", only_path: true)
    end

end
