class AddEventToParis < ActiveRecord::Migration[7.0]
  def change
    add_reference :paris, :event, null: false, foreign_key: true
  end
end
