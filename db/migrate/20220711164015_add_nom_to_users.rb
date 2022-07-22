class AddNomToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nom, :string
  end
end
