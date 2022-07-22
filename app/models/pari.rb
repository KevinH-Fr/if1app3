class Pari < ApplicationRecord
    belongs_to :parieur, :class_name => 'Pilote', :optional => true
    belongs_to :coureur, :class_name => 'Pilote', :optional => true

    validates :coureur_id, presence: true
    validates :parieur_id, presence: true
    
    validates :typepari, presence: true
   

    enum typepari: [:victoire, :podium, :top10]
    #TYPES_PARI = ["victoire", "podium"]

   # scope :typevictoire, -> { where(typepari: 'victoire')}

    scope :event_courant, -> (event_courant) { where(event_id: event_courant)}

    after_initialize :set_default_montant, :set_default_cote, :if => :new_record?
    def set_default_montant
      self.montant ||= 0
    end

    def set_default_cote
        self.cote ||= 0
      end

end
