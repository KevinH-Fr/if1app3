class AddPositionToClassements < ActiveRecord::Migration[7.0]
  def change
    add_column :classements, :position, :integer
  end
end
