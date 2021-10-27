class User < ApplicationRecord
    #attr_accessible :username, :avatar_url, :user_id
    has_many :tourneys

    def self.create_from_oauth(params)
        user = User.find_or_create_by(user_id: params['id']) do |u|
            u.username = params['username']
            u.avatar_url = params['avatar_url']
            u.user_id = params['id']
          end
          user.update(avatar_url: params['avatar_url']) if user.avatar_url != params['avatar_url']
          user.update(username: params['username']) if user.username != params['username']
          user
    end
end
