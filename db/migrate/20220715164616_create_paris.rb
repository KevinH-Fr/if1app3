class CreateParis < ActiveRecord::Migration[7.0]
  def change
    create_table :paris do |t|
      t.string :typePari
      t.references :parieur
      t.references :coureur
      t.timestamps
    end
  
      add_foreign_key :paris, :pilotes, column: :parieur_id, primary_key: :id
      add_foreign_key :paris, :pilotes, column: :coureur_id, primary_key: :id
  end
end
