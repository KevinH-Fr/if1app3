class Circuit < ApplicationRecord
    has_one_attached :drapeau
    has_one_attached :carte

    has_many :events, :dependent => :delete_all 
    
end
