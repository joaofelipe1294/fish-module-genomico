class CheckRgbValidator < ActiveModel::Validator

  def validate(record)
    unless record.rgb.attached?
      record.errors[:rgb] << "Imagem rgb do núcleo não encontrada"
    end
  end

end
