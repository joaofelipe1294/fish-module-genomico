module ResponsibleReference
  extend ActiveSupport::Concern

  included do
    validates_presence_of :responsible_id, :responsible_login
  end

end
