class AddColumnToArtworks < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :favorite, :boolean, default: false, null: false
  end
end
