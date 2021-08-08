class User < ApplicationRecord
    has_secure_password
    validates_presence_of :password, :on => :create
    attr_accessible :name, :email, :password, :password_confirmation
end
