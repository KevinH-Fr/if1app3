class Event < ApplicationRecord
  belongs_to :saison, :optional => true
  belongs_to :circuit, :optional => true

  has_many :resultats, :dependent => :delete_all 
  has_many :paris, :dependent => :delete_all


    def formatted_name
       datetime = date.to_date
       datetime.strftime("%d/%m/%y")
        "#{datetime} | #{circuit_id} | #{division}"
    end

    def formatted_name_bis
      pays = Circuit.find(circuit_id).pays
      datetime = date
      "n°#{numero} - | #{pays} - | #{datetime}"
    end 

    before_validation :horaire_defaut

    private
  
    def horaire_defaut
      if self.horaire.blank?
        self.horaire = "21:00"
      end
    end

end
