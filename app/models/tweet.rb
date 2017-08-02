# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Tweet < ApplicationRecord

    belongs_to :user

    validates :content, presence: true, length: { maximum: 140 }
    validates :user_id, presence: true

    default_scope -> { order(created_at: :desc) }

end
