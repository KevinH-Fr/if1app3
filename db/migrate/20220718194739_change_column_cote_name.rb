class ChangeColumnCoteName < ActiveRecord::Migration[7.0]
  def change
    rename_column :classements, :cote, :cote_victoire
  end
end
