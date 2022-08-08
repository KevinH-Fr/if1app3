class Licence < ApplicationRecord
    belongs_to :pilote, :optional => true
    belongs_to :event, :optional => true

    scope :group_by_pilote, -> { group('pilote_id') }
    
    scope :sum_pena_by_pilote, -> { sum('penalite') }   
    scope :sum_recup_by_pilote, -> { sum('recupere') }   
   
end
