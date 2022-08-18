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
      divisionNum = Division.find(division_id).numero
      pays = Circuit.find(circuit_id).pays
      datetime = date.to_date
     
      "n°#{numero} | #{pays} | D #{divisionNum} | #{ datetime.strftime("%d/%m/%y")}"
    end 

    before_validation :horaire_defaut

    private
  
    def horaire_defaut
      if self.horaire.blank?
        self.horaire = "21:00"
      end
    end

end
