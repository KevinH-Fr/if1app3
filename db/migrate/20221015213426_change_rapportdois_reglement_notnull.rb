class ChangeRapportdoisReglementNotnull < ActiveRecord::Migration[7.0]
  def change
    change_column_null:rapportdois,:reglement_id,true, "vide"
  end
end
