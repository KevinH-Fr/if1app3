class AddPenalitetempsToReglements < ActiveRecord::Migration[7.0]
  def change
    add_column :reglements, :penalitetemps, :string
  end
end
