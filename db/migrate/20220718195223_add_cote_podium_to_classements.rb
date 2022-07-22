class AddCotePodiumToClassements < ActiveRecord::Migration[7.0]
  def change
    add_column :classements, :cote_podium, :decimal
  end
end
