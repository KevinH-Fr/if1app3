class AddDemandeurToRapportdois < ActiveRecord::Migration[7.0]
  def change
    add_column :rapportdois, :demandeur, :string
  end
end
