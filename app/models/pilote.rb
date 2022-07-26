class Pilote < ApplicationRecord
    belongs_to :equipe, :optional => true
    belongs_to :division, :optional => true
    
    has_many :resultats, :dependent => :delete_all 

    has_many :fait_paris, :class_name => 'Pari', :foreign_key => 'parieur_id'
    has_many :recu_paris, :class_name => 'Pari', :foreign_key => 'coureur_id'

    validates :nom, presence: true, uniqueness: true, on: :create
    validates :division_id, presence: true

    scope :statut_actif, -> { where(statut: "actif") }
    scope :division_courant, -> (division_courant) { where(division_id: division_courant)}
    scope :division_non_courant, -> (division_courant) { where.not(division_id: division_courant)}

    scope :total_points, -> { Resultat.select('SUM(score) AS total') }

    

end
