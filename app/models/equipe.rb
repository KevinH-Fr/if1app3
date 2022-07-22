class Equipe < ApplicationRecord
    has_many :pilotes
    has_one_attached :logo
    has_one_attached :voiture
end
