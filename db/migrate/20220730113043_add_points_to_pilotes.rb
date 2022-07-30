class AddPointsToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_column :pilotes, :points, :integer
  end
end
