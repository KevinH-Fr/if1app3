class CreateRapportdois < ActiveRecord::Migration[7.0]
  def change
    create_table :rapportdois do |t|
      t.references :event, null: false, foreign_key: true
      t.references :pilote, null: false, foreign_key: true
      t.string :pilote2
      t.string :responsable
      t.references :reglement, null: false, foreign_key: true
      t.integer :penalitelicence
      t.integer :penalitetemps
      t.text :commentaire

      t.timestamps
    end
  end
end
