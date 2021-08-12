class User < ApplicationRecord
    has_secure_password
    #validates_presence_of :password, :on => :create
    #attr_accessor :username, :email, :password, :password_confirmation
end
