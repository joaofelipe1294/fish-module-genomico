class Slice < ApplicationRecord
  validates_presence_of :responsible_id, :responsible_login, :date, :subsample_id, :subsample_label, :probe
  enum probe: {
    bcr_abl: 1,
  }

  def self.probes_for_select
    probes.map do |probe, _|
      [ I18n.t("enums.slice.probes.#{probe}"), probe ]
    end
  end

end
