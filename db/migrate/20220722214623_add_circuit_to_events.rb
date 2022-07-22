class AddCircuitToEvents < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :circuit, null: true, foreign_key: true
  end
end
