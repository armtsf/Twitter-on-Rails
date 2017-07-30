class User < ApplicationRecord

    has_many :tweets, dependent: :destroy
    
end
