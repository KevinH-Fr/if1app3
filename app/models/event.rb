class Event < ApplicationRecord
  belongs_to :saison, :optional => true
  belongs_to :circuit, :optional => true

  has_many :resultats, :dependent => :delete_all 

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




   # scope :event_courant, -> (event_courant) { where(event_id: event_courant)}
 
 #  scope :division_courant, -> (division_courant) { where(division_id: division_courant)}
 


end
