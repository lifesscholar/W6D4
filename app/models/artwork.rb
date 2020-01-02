# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorite   :boolean          default(FALSE), not null
#

class Artwork < ApplicationRecord

    validates :title, :image_url, :artist_id, presence: true
    validates :title, uniqueness:  { scope: :artist_id }

    belongs_to :artist,
        class_name: :User,
        primary_key: :id,
        foreign_key: :artist_id

    has_many :shares,
        class_name: :ArtworkShare,
        primary_key: :id,
        foreign_key: :artwork_id,
        dependent: :destroy

    has_many :shared_viewers,
        through: :shares,
        source: :viewer

    has_many :comments,
        class_name: :Comment,
        primary_key: :id,
        foreign_key: :artwork_id,
        dependent: :destroy

    has_many :likes, as: :likable

    has_many :artwork_collections,
        class_name: :ArtworkCollection,
        primary_key: :id,
        foreign_key: :artwork_id,
        dependent: :destroy

    has_many :collections,
        through: :artwork_collections,
        source: :collection
end
