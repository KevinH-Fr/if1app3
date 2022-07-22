class CreateClassecuries < ActiveRecord::Migration[7.0]
  def change
    create_table :classecuries do |t|

      t.timestamps
    end
  end
end
