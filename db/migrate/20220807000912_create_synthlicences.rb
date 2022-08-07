class CreateSynthlicences < ActiveRecord::Migration[7.0]
  def change
    create_table :synthlicences do |t|

      t.timestamps
    end
  end
end
