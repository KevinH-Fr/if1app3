class AddRangN0ToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_column :pilotes, :rang_n0, :string
    add_column :pilotes, :integer, :string
  end
end
