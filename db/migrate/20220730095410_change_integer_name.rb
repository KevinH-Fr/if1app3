class ChangeIntegerName < ActiveRecord::Migration[7.0]
  def change
    rename_column :pilotes, :integer, :rang_n1
  end
end
