class AddCoteToParis < ActiveRecord::Migration[7.0]
  def change
    add_column :paris, :cote, :decimal
  end
end
