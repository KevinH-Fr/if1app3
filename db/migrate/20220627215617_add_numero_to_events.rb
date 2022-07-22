class AddNumeroToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :numero, :integer
  end
end
