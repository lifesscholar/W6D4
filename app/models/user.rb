# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :artworks,
        class_name: :Artwork,
        primary_key: :id,
        foreign_key: :artist_id,
        dependent: :destroy

    has_many :shares,
        class_name: :ArtworkShare,
        primary_key: :id,
        foreign_key: :viewer_id,
        dependent: :destroy

    has_many :shared_artworks,
        through: :shares,
        source: :artwork

    has_many :comments,
        class_name: :Comment,
        primary_key: :id,
        foreign_key: :user_id,
        dependent: :destroy

    has_many :likes,
        class_name: :Like,
        primary_key: :id,
        foreign_key: :user_id

    has_many :collections,
        class_name: :Collection,
        primary_key: :id,
        foreign_key: :user_id,
        dependent: :destroy

    def favorites
        own_favorites = self.artworks.where(favorite: true)
        shared_favorites = self.shared_artworks.where("artwork_shares.favorite = true")
        own_favorites + shared_favorites
    end

end
