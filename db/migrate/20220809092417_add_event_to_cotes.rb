class AddEventToCotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :cotes, :event, null: false, foreign_key: true
  end
end
