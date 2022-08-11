class AddHoraireToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :horaire, :datetime
  end
end
