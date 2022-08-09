class AddCotePoleToCotes < ActiveRecord::Migration[7.0]
  def change
    add_column :cotes, :cotePole, :decimal
  end
end
