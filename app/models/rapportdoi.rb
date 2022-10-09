class Rapportdoi < ApplicationRecord
  belongs_to :event
  belongs_to :pilote
  belongs_to :reglement

  validates :reglement_id, presence: true
end
