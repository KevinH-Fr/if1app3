class AddDecisionToRapportdois < ActiveRecord::Migration[7.0]
  def change
    add_column :rapportdois, :decision, :string
  end
end
