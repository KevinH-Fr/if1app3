class Rapportdoi < ApplicationRecord
  belongs_to :event
  belongs_to :pilote, :optional => true
  belongs_to :reglement

  validates :reglement_id, presence: true

  scope :event_courant, -> (event_courant) { where("event_id = ?", event_courant)}
  scope :pilote_courant, -> (pilote_courant) { where("pilote_id = ?", pilote_courant)}
  scope :sum_penalite, -> { sum('penalitelicence') }

end
