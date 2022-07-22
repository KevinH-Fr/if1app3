class CreateCircuits < ActiveRecord::Migration[7.0]
  def change
    create_table :circuits do |t|
      t.string :nom
      t.string :pays

      t.timestamps
    end
  end
end
