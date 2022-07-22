class Pari < ApplicationRecord
    belongs_to :parieur, :class_name => 'Pilote', :optional => true
    belongs_to :coureur, :class_name => 'Pilote', :optional => true

    belongs_to :event, :optional => true

    validates :coureur_id, presence: true
    validates :parieur_id, presence: true
    
    validates :paritype, presence: true
   
    enum paritype: [:victoire, :podium, :top10]


    scope :division_courant, -> (division_courant) { joins(:event).where("division_id = ?", division_courant)}

    scope :saison_courant, -> (saison_courant) { joins(:event).where("saison_id = ?", saison_courant)}
    scope :event_courant, -> (event_courant) { where("event_id = ?", event_courant)}
    scope :pilote_courant, -> (pilote_courant) { where("parieur_id = ?", pilote_courant)}
    scope :numero_until_courant, -> (numero_until_courant) { joins(:event).where("numero <= ?", numero_until_courant)}

    scope :group_sum_order, -> { select('parieur_id, SUM(solde) AS total').group('parieur_id').order('total').reverse }

    scope :sum_parieur, -> {select('parieur_id, SUM(solde) AS total')}

    

    after_initialize :set_default_montant, :set_default_cote, :if => :new_record?
    def set_default_montant
      self.montant ||= 0
    end

    def set_default_cote
        self.cote ||= 0
      end

end
