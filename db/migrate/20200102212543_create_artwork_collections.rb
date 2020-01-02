class CreateArtworkCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_collections do |t|
      t.integer :collection_id, null: false, index: true
      t.integer :artwork_id, null: false, index: true
    end

    add_index :artwork_collections, [:collection_id, :artwork_id], unique: true
    
  end
end
