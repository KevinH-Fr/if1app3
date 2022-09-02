class AddCouleurRgbToEquipes < ActiveRecord::Migration[7.0]
  def change
    add_column :equipes, :couleurRgb, :string
  end
end
