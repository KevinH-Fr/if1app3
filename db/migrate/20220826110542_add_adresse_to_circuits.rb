class AddAdresseToCircuits < ActiveRecord::Migration[7.0]
  def change
    add_column :circuits, :adresse, :string
  end
end
