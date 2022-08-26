class AddLatitudeToCircuits < ActiveRecord::Migration[7.0]
  def change
    add_column :circuits, :latitude, :decimal
  end
end
