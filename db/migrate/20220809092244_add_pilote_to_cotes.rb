class AddPiloteToCotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :cotes, :pilote, null: false, foreign_key: true
  end
end
