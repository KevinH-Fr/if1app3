class AddEventRefToResultats < ActiveRecord::Migration[7.0]
  def change
    add_reference :resultats, :event, null: true, foreign_key: true
  end
end
