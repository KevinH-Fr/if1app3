class Classement < ApplicationRecord
  #  has_many :events, through: :resultats
  belongs_to :event, :optional => true
  #before_validation :toggle_creerclassements
  #include Sluggable;

 # has_many :resultats, :dependent => :delete_all 

 scope :event_courant, -> (event_courant) { where("event_id = ?", event_courant)}
 
 scope :saison_courant, -> (saison_courant) { joins(:event).where("saison_id = ?", saison_courant)}
 scope :division_courant, -> (division_courant) { joins(:event).where("division_id = ?", division_courant)}
 scope :numero_until_courant, -> (numero_until_courant) { joins(:event).where("numero <= ?", numero_until_courant)}

 scope :order_by_score, -> { order('score').reverse }


 scope :max_points, -> { all.order(score: :DESC).first }






end