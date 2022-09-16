class Classement < ApplicationRecord
  #  has_many :events, through: :resultats
  belongs_to :event, :optional => true

 # has_many :resultats, :dependent => :delete_all 

 scope :event_courant, -> (event_courant) { where("event_id = ?", event_courant)}
 
 scope :saison_courant, -> (saison_courant) { joins(:event).where("saison_id = ?", saison_courant)}
 scope :division_courant, -> (division_courant) { joins(:event).where("division_id = ?", division_courant)}
 scope :numero_until_courant, -> (numero_until_courant) { joins(:event).where("numero <= ?", numero_until_courant)}

 scope :numero_precedent, -> (numero_precedent) { joins(:event).where("numero = ?", numero_precedent)}

 scope :order_by_score, -> { order('score').reverse }

 #scope :compte_p1, -> { where("(course) = 1").count}

scope :order_score_positions, 
      -> {order(score: :DESC, 
        nb_p1: :DESC, nb_p2: :DESC, nb_p3: :DESC, nb_p4: :DESC, nb_p5: :DESC,    
        nb_p6: :DESC, nb_p7: :DESC, nb_p8: :DESC, nb_p9: :DESC, nb_p10: :DESC,
        nb_p11: :DESC, nb_p12: :DESC, nb_p13: :DESC, nb_p14: :DESC, nb_p15: :DESC,     
        nb_p16: :DESC, nb_p17: :DESC, nb_p18: :DESC, nb_p19: :DESC, nb_p20: :DESC      
        ) }
      


  # tests : 

 scope :max_points, -> { all.order(score: :DESC).first }




end