class AddScoreToClassements < ActiveRecord::Migration[7.0]
  def change
    add_column :classements, :score, :decimal
  end
end
