class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.date :date
      t.string :circuit
      t.string :division

      t.timestamps
    end
  end
end
