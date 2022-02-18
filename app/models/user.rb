class User < ApplicationRecord
    #attr_accessible :username, :avatar_url, :user_id
    has_many :tourneys

    enum role: [
        :member,
        :admin
    ]

    def self.create_from_oauth(params)
        user = User.find_or_create_by(user_id: params['id']) do |u|
            u.id = params['id']
            u.username = params['username']
            u.avatar_url = params['avatar_url']
            u.user_id = params['id']
            u.twitter = params['twitter']
        end
        user.update(avatar_url: params['avatar_url']) if user.avatar_url != params['avatar_url']
        user.update(username: params['username']) if user.username != params['username']
        user.update(twitter: params['twitter']) if user.twitter != params['twitter']
        
        user
    end
end
