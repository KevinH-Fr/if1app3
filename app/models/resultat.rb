class Resultat < ApplicationRecord

  enum positions: {1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 
                     6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10,
                     11 => 11, 12 => 12, 13 => 13, 14 => 14, 15 => 15,
                     16 => 16, 17 => 17, 18 => 18, 19 => 19, 20 => 20
    }

    belongs_to :pilote, :optional => true
    belongs_to :event, :optional => true
    belongs_to :saison, :optional => true

    validates :pilote_id, presence: true
    validates :ecurie, presence: true
    validates :event_id, presence: true

    scope :with_mt, -> { where("(mt) = true") }

scope :division_courant, -> (division_courant) { joins(:event).where("division_id = ?", division_courant)}
scope :saison_courant, -> (saison_courant) { joins(:event).where("saison_id = ?", saison_courant)}
scope :event_courant, -> (event_courant) { where("event_id = ?", event_courant)}

scope :pilote_courant, -> (pilote_courant) { where("pilote_id = ?", pilote_courant)}

scope :numero_until_courant, -> (numero_until_courant) { joins(:event).where("numero <= ?", numero_until_courant)}

# tempo
scope :group_by_pilote, -> { group('pilote_id') }
scope :group_by_ecurie, -> { group('ecurie') }

scope :sum_by_pilote, -> { sum('score') }

scope :sum_order_score, -> { select('pilote_id, score, SUM(score) AS total')}


scope :compte_p1, -> { where("(course) = 1").count}

scope :compte_p2, -> { where("(course) = 2").count}
scope :compte_p3, -> { where("(course) = 3").count}
scope :compte_p4, -> { where("(course) = 4").count}
scope :compte_p5, -> { where("(course) = 5").count}

scope :compte_podium, -> {where("(course) <= 3").count}
scope :compte_top5, -> {where("(course) <= 5").count}
scope :compte_top10, -> {where("(course) <= 10").count}

scope :nb_courses, -> (pilote_courant) { where("pilote_id = ?", pilote_courant).count}

scope :order_score_positions, 
      -> {order(score: :DESC ) }


scope :order_by_sum, -> { order(score.to_i).reverse }

# utilisée
scope :group_sum_order, -> { select('pilote_id, SUM(score) AS total').group('pilote_id').order('total').reverse }
  


end
