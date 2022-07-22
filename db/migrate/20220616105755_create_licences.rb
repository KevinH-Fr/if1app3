class CreateLicences < ActiveRecord::Migration[7.0]
  def change
    create_table :licences do |t|
      t.integer :penalite
      t.integer :recupere

      t.timestamps
    end
  end
end
