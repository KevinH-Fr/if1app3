class ChangeSoldeType < ActiveRecord::Migration[7.0]
  def change
    change_column(:paris, :solde, :decimal)
  end
end
