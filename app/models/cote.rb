class Cote < ApplicationRecord
    belongs_to :event, :optional => true

    
 scope :event_courant, -> (event_courant) { where("event_id = ?", event_courant)}
 
 scope :saison_courant, -> (saison_courant) { joins(:event).where("saison_id = ?", saison_courant)}
 scope :division_courant, -> (division_courant) { joins(:event).where("division_id = ?", division_courant)}
 scope :numero_until_courant, -> (numero_until_courant) { joins(:event).where("numero <= ?", numero_until_courant)}

 scope :order_by_score, -> { order('score').reverse }

 scope :cote_victoire, ->  {position * 2}


 # ajouter une methode pour modifier la valeur ed la cote ? 
 # le modele permettrait de passer une formule de calcul, modifiable dans le model si beosin, et recupérée partout ou utile 
 # passer position et score pour calculer cote victoire podium etc ?











 ####################################

 def initialize
  @instance_var = "instance variable"
  @@class_variable = "class variable"
 end
 
 def say_hi
   "hello #{@instance_var}" 
 end

end
  
  