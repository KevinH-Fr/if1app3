class AddPiloteRefToResultats < ActiveRecord::Migration[7.0]
  def change
    add_reference :resultats, :pilote, null: true, foreign_key: true
  end
end
