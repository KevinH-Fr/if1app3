class CreateSaisons < ActiveRecord::Migration[7.0]
  def change
    create_table :saisons do |t|
      t.string :nom
      t.integer :numeroSaison
      t.date :periode

      t.timestamps
    end
  end
end
