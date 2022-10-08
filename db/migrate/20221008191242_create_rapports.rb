class CreateRapports < ActiveRecord::Migration[7.0]
  def change
    create_table :rapports do |t|
      t.references :event, null: false, foreign_key: true
      t.references :pilote1, null: false, foreign_key: true
      t.references :pilote2, null: false, foreign_key: true
      t.references :responsable, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.integer :penalitelicence
      t.integer :penalitetemps
      t.text :commentaire

      t.timestamps
    end
  end
end
