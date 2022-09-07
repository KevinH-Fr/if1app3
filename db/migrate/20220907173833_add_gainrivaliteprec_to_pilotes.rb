class AddGainrivaliteprecToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_column :pilotes, :Gainrivaliteprec, :boolean
  end
end
