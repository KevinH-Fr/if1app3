class AddNbP4ToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_column :pilotes, :nb_p4, :integer
  end
end
