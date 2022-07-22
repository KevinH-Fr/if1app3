class RemoveEventFromResultats < ActiveRecord::Migration[7.0]
  def change
    remove_column :resultats, :event, :string
  end
end
