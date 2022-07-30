class AddNbP1ToClassements < ActiveRecord::Migration[7.0]
  def change
    add_column :classements, :nb_p1, :integer
  end
end
