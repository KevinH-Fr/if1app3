class AddNbP2ToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_column :pilotes, :nb_p2, :integer
  end
end
