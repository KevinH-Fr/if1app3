class Event < ApplicationRecord
  belongs_to :saison, :optional => true
  belongs_to :circuit, :optional => true

  has_many :resultats, :dependent => :delete_all 
  has_many :paris, :dependent => :delete_all


  scope :saison_courant, -> (saison_courant) { where("saison_id = ?", saison_courant)}
  scope :division_courant, -> (division_courant) { where("division_id = ?", division_courant)}
  scope :numero_until_courant, -> (numero_until_courant) { where("numero <= ?", numero_until_courant)}

    def formatted_name
       datetime = date.to_date
       datetime.strftime("%d/%m/%y")
        "#{datetime} | #{circuit_id} | #{division}"
    end

    def formatted_name_bis
      divisionNum = Division.find(division_id).numero
      pays = Circuit.find(circuit_id).pays

       datetime = date.to_date
        "n°#{numero} | #{pays} | D #{divisionNum} | #{ date.strftime("%d/%m/%y")}"
   

    end 

    before_validation :horaire_defaut

    private
  
    def horaire_defaut
      if self.horaire.blank?
        self.horaire = "21:00"
      end
    end

end
