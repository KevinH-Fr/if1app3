class Licence < ApplicationRecord
    belongs_to :pilote, :optional => true
    belongs_to :event, :optional => true

   
end
