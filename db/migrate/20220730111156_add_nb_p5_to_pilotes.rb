class AddNbP5ToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_column :pilotes, :nb_p5, :integer
  end
end
