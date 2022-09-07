class AddManuelToParis < ActiveRecord::Migration[7.0]
  def change
    add_column :paris, :manuel, :boolean
  end
end
