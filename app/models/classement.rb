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

 scope :compte_p1, -> { where("(course) = 1").count}
 scope :compte_p2, -> { where("(course) = 2").count}
 #scope :compte_p3, -> { where("(course) = 3").count}
 #scope :compte_p4, -> { where("(course) = 4").count}
 #scope :compte_p5, -> { where("(course) = 5").count}
 #scope :compte_p6, -> { where("(course) = 6").count}
 #scope :compte_p7, -> { where("(course) = 7").count}
 #scope :compte_p8, -> { where("(course) = 8").count}
 #scope :compte_p9, -> { where("(course) = 9").count}
 #scope :compte_p10, -> { where("(course) = 10").count}
 #scope :compte_p11, -> { where("(course) = 11").count}
 #scope :compte_p12, -> { where("(course) = 12").count}
 #scope :compte_p13, -> { where("(course) = 13").count}
 #scope :compte_p14, -> { where("(course) = 14").count}
 #scope :compte_p15, -> { where("(course) = 15").count}
 #scope :compte_p16, -> { where("(course) = 16").count}
 #scope :compte_p17, -> { where("(course) = 17").count}
 #scope :compte_p18, -> { where("(course) = 18").count}
 #scope :compte_p19, -> { where("(course) = 19").count}
 #scope :compte_p20, -> { where("(course) = 20").count}

scope :order_score_positions, 
      -> {order(score: :DESC, nb_p1: :DESC, nb_p2: :DESC, nb_p3: :DESC, nb_p4: :DESC, nb_p5: :DESC ) }
        #, compte_p3: :DESC, compte_p4: :DESC, compte_p5: :DESC,
        #                      compte_p6: :DESC, compte_p7: :DESC, compte_p8: :DESC, compte_p9: :DESC, compte_p10: :DESC,
        #                      compte_p11: :DESC, compte_p12: :DESC, compte_p13: :DESC, compte_p14: :DESC, compte_p15: :DESC,
        #                      compte_p16: :DESC, compte_p17: :DESC, compte_p18: :DESC, compte_p19: :DESC, compte_p20: :DESC ) }


  # tests : 

 scope :max_points, -> { all.order(score: :DESC).first }




end