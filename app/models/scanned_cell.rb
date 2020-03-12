class ScannedCell < ApplicationRecord
  belongs_to :scanning_image
  before_validation :set_label
  enum label: {
    positive: 1,
    negative: 0
  }

  private

    def set_label
      self.label = :positive unless self.label
    end

end
