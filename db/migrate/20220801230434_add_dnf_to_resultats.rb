class AddDnfToResultats < ActiveRecord::Migration[7.0]
  def change
    add_column :resultats, :dnf, :boolean
    add_column :resultats, :dns, :boolean
  end
end
