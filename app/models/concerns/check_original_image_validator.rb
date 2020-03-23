class CheckOriginalImageValidator < ActiveModel::Validator

  def validate(record)
    unless record.original.attached?
      record.errors[:original] << "Imagem png original não encontrada"
    end
  end

end
