class AddPiloteRefToLicences < ActiveRecord::Migration[7.0]
  def change
    add_reference :licences, :pilote, null: true, foreign_key: true
  end
end
