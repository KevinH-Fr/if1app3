class ChangeTypepariType < ActiveRecord::Migration[7.0]
  def change
    change_column(:paris, :typePari, :integer)
  end
end
