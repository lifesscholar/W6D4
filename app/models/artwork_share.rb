# == Schema Information
#
# Table name: artwork_shares
#
#  id         :bigint           not null, primary key
#  artwork_id :integer          not null
#  viewer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorite   :boolean          default(FALSE)
#

class ArtworkShare < ApplicationRecord
    validates :artwork_id, uniqueness: { scope: :viewer_id }
    validates :artwork_id, :viewer_id, presence: true

    belongs_to :artwork,
        class_name: :Artwork,
        primary_key: :id,
        foreign_key: :artwork_id

    belongs_to :viewer,
        class_name: :User,
        primary_key: :id,
        foreign_key: :viewer_id

end
