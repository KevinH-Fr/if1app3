class CreateReglements < ActiveRecord::Migration[7.0]
  def change
    create_table :reglements do |t|
      t.string :version
      t.string :titre
      t.string :numero
      t.text :description
      t.integer :penalite

      t.timestamps
    end
  end
end
