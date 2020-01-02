# == Schema Information
#
# Table name: artwork_collections
#
#  id            :bigint           not null, primary key
#  collection_id :integer          not null
#  artwork_id    :integer          not null
#

class ArtworkCollection < ApplicationRecord
    validates :collection_id, :artwork_id, presence: true
    validates :artwork_id, uniqueness: { scope: :collection_id}

    belongs_to :collection,
        class_name: :Collection,
        primary_key: :id,
        foreign_key: :collection_id

    belongs_to :artwork,
        class_name: :Artwork,
        primary_key: :id,
        foreign_key: :artwork_id
    
end
