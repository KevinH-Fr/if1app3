class AddPositionToCotes < ActiveRecord::Migration[7.0]
  def change
    add_column :cotes, :position, :integer
  end
end
