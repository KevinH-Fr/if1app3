class AddResultatToParis < ActiveRecord::Migration[7.0]
  def change
    add_column :paris, :resultat, :boolean
  end
end
