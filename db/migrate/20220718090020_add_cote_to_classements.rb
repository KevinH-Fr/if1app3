class AddCoteToClassements < ActiveRecord::Migration[7.0]
  def change
    add_column :classements, :cote, :decimal
  end
end
