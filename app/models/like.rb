# == Schema Information
#
# Table name: likes
#
#  id           :bigint           not null, primary key
#  user_id      :integer          not null
#  likable_type :string           not null
#  likable_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Like < ApplicationRecord

    validates :user_id, :likable_id, :likable_type, presence: true

    validates :user_id, uniqueness: { scope: [:likable_id, :likable_type], message: "you have already liked this" }

    belongs_to :user,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    belongs_to :likable, polymorphic: true

end
