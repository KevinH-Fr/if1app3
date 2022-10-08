class AddCommentaireToReglements < ActiveRecord::Migration[7.0]
  def change
    add_column :reglements, :commentaire, :text
  end
end
