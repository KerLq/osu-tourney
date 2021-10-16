class User < ApplicationRecord
    has_secure_password
    validates :password, length: { minimum: 3 }, if: :password_digest_changed?
    #validates_presence_of :password, :on => :create
    #attr_accessible :username, :email, :password, :password_confirmation
end
