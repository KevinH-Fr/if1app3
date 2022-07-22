class AddEcurieIdToResultats < ActiveRecord::Migration[7.0]
  def change
    add_column :resultats, :ecurie, :integer
  end
end
