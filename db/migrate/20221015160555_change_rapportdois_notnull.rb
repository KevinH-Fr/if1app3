class ChangeRapportdoisNotnull < ActiveRecord::Migration[7.0]
  def change
    change_column_null:rapportdois,:pilote_id,true, "vide"
  end
end
