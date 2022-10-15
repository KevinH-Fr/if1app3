class DropRapportsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :rapports
  end
end
