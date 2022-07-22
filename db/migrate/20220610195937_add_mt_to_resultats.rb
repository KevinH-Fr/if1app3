class AddMtToResultats < ActiveRecord::Migration[7.0]
  def change
    add_column :resultats, :mt, :boolean
  end
end
