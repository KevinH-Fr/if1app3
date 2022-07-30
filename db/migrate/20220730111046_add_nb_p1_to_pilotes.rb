class AddNbP1ToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_column :pilotes, :nb_p1, :integer
  end
end
