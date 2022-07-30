class AddNbP2ToClassements < ActiveRecord::Migration[7.0]
  def change
    add_column :classements, :nb_p2, :integer
    add_column :classements, :nb_p3, :integer
    add_column :classements, :nb_p4, :integer
    add_column :classements, :nb_p5, :integer
  end
end
