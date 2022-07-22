class RemovePiloteFromResultats < ActiveRecord::Migration[7.0]
  def change
    remove_column :resultats, :pilote, :string
  end
end
