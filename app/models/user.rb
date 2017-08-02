# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  handle             :string
#  name               :string
#  encrypted_password :string
#  email              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord

    attr_accessor :password

    before_save :encrypt_password

    has_many :tweets, dependent: :destroy

    validates :name, presence: true, length: { maximum: 50 }
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: email_regex }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, confirmation: true, length: { minimum: 8}

    def has_password?(submitted_password)
        encrypted_password == encrypt(submitted_password)
    end

    def self.authenticate(email, submitted_password)
        user = find_by_email(email)
        return nil if user.nil?
        return user if user.has_password?(submitted_password)
    end

    def self.authenticate_with_salt(id, cookie_salt) 
        user = find_by_id(id)
        (user && user.salt == cookie_salt) ? user : nil
    end

    def feed
        Tweet.where("user_id = ?", id)
    end

    private

        def encrypt_password
            self.salt = make_salt if new_record? 
            self.encrypted_password = encrypt(password)
        end
    
        def encrypt(string) 
            secure_hash("#{salt}--#{string}")
        end
    
        def make_salt 
            secure_hash("#{Time.now.utc}--#{password}")
        end
    
        def secure_hash(string) 
            Digest::SHA2.hexdigest(string)
        end

end
