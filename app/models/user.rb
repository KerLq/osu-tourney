class User < ApplicationRecord
    attr_accessor :username, :avatar_url, :user_id
    has_many :tourneys
end
