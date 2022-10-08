class Rapport < ApplicationRecord
  belongs_to :event, :optional => true
  belongs_to :pilote, :optional => true

end
