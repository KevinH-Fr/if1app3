class CreateParieurs < ActiveRecord::Migration[7.0]
  def change
    create_table :parieurs do |t|
      t.references :pilote, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.decimal :cumul

      t.timestamps
    end
  end
end
