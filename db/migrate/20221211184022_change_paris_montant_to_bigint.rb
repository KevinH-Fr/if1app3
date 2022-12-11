class ChangeParisMontantToBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :paris, :montant, :bigint
  end
end
