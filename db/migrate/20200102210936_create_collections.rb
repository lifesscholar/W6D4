class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.integer :user_id, null: false, index: true
      t.timestamps
    end
  end
end
