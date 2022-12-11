class ChangeParieursCumulToBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :parieurs, :cumul, :bigint
  end
end
