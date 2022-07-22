class AddCoteTop10ToClassements < ActiveRecord::Migration[7.0]
  def change
    add_column :classements, :cote_top10, :decimal
  end
end
