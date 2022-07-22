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

    scope :group_sum_order, -> { select('parieur_id, SUM(solde) AS total').group('parieur_id, total').order('parieur_id, total').reverse }

    scope :sum_parieur, -> {select('parieur_id, SUM(solde) AS total')}


    validate :verif_montant

    def verif_montant

      eventId = event_id # recupere l'id event du record pari courant (s'applique a chaque record)
      divisionId = Event.find(eventId).division_id
      saisonId = Event.find(eventId).saison_id
      eventNum = Event.find(eventId).numero 

      soldeParieurAvant = Pari.saison_courant(saisonId).division_courant(divisionId).numero_until_courant(eventNum).pilote_courant(self.parieur_id).sum_parieur.first.total

      if soldeParieurAvant.present?
        if soldeParieurAvant - montant < 0 
          errors.add(:montant, "insuffisant, impossible de miser plus que votre solde de points.")
        end
      else
        if 1000 - montant < 0 
          errors.add(:montant, "insuffisant, impossible de miser plus que votre solde de points.")
        end
      end
    end






    after_initialize :set_default_montant, :set_default_cote, :if => :new_record?
    def set_default_montant
      self.montant ||= 0
    end

    def set_default_cote
        self.cote ||= 0
      end

end
