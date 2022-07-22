class Saison < ApplicationRecord
    has_many :events, :dependent => :delete_all 
end
