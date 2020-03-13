class FishSlice < ApplicationRecord
  include ResponsibleReference
  validates_presence_of :date, :probe, :genomico_exam_id
  has_one :exam
  accepts_nested_attributes_for :exam, allow_destroy: true
  paginates_per 10
  has_many :scannings
  enum probe: {
    bcr_abl: 1,
  }

  def self.probes_for_select
    probes.map do |probe, _|
      [ I18n.t("enums.fish_slice.probes.#{probe}"), probe ]
    end
  end

  def probe_name
    I18n.t("enums.fish_slice.probes.#{self.probe}")
  end

end
