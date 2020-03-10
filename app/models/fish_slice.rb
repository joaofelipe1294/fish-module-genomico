class FishSlice < ApplicationRecord
  validates_presence_of :responsible_id, :responsible_login, :date, :probe, :genomico_exam_id
  has_one :exam
  accepts_nested_attributes_for :exam
  paginates_per 10
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
