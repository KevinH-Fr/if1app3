class AddNbP3ToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_column :pilotes, :nb_p3, :integer
  end
end
