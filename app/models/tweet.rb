class Tweet < ApplicationRecord

    belongs_to :user

    validates :content, presence: true, length: { maximum: 140 }

end
