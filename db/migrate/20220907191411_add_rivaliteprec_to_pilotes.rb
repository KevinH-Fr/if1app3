class AddRivaliteprecToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_column :pilotes, :rivaliteprec, :boolean
  end
end
