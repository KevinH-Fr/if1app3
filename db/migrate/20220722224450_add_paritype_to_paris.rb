class AddParitypeToParis < ActiveRecord::Migration[7.0]
  def change
    add_column :paris, :paritype, :integer
  end
end
