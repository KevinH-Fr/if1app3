class Rapportdoi < ApplicationRecord
  belongs_to :event
  belongs_to :pilote, :optional => true
  belongs_to :reglement

  validates :reglement_id, presence: true



end
