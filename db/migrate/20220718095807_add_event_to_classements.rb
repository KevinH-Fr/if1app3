class AddEventToClassements < ActiveRecord::Migration[7.0]
  def change
    add_reference :classements, :event, null: false, foreign_key: true
  end
end
