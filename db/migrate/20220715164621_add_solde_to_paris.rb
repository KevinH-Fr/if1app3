class AddSoldeToParis < ActiveRecord::Migration[7.0]
  def change
    add_column :paris, :solde, :integer
  end
end
