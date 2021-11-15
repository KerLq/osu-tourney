class User < ApplicationRecord
    #attr_accessible :username, :avatar_url, :user_id
    has_many :tourneys

    enum role: [
        :member,
        :admin
    ]

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

    def sendDiscordNotification(user, user_path)
        uri = "https://discord.com/api/webhooks/908382804646187058/jPQ25lL6c6eZmZZEMDmpEnNrqEcRiS3vDqGhDpjf9PWp2DqoJJSgwHRBL9QSjlwmEPmI"

        body = {
            "username":"osu!tourney",
            "avatar_url":"https://cdn.discordapp.com/attachments/849604504613945364/904385120251809802/XOhIzgk.png",
            "embeds": [
                {
                "author": {
                  "name":"Recent Logins",
                  "url":"https://localhost:3000#{user_path}",
                },
                "title":"#{user.username}",
                "url":"https://localhost:3000#{user_path}",
                "description":"User **#{user.username}** has logged in!",
                "image": {
                    "url":"#{user.avatar_url}"
                },
                "thumbnail": {
                    "url":"https://cdn.discordapp.com/attachments/849604504613945364/904385120251809802/XOhIzgk.png"
                }
            }
            
                
            ]
        }

        response = HTTParty.post(uri,
            body: body.to_json,
            headers: {'Content-Type':'application/json'}
        )
        user
    end

    def sendDiscordNotificationResponse(response)
        
        uri = "https://discord.com/api/webhooks/908382804646187058/jPQ25lL6c6eZmZZEMDmpEnNrqEcRiS3vDqGhDpjf9PWp2DqoJJSgwHRBL9QSjlwmEPmI"

        body = {
            "username":"osu!tourney",
            "avatar_url":"https://cdn.discordapp.com/attachments/849604504613945364/904385120251809802/XOhIzgk.png",
            "embeds": [
                {
                "title":"GET-REQUEST | getMatches",
                "description":"#{response}",
                "thumbnail": {
                    "url":"https://cdn.discordapp.com/attachments/849604504613945364/904385120251809802/XOhIzgk.png"
                }
            }
            
                
            ]
        }

        response = HTTParty.post(uri,
            body: body.to_json,
            headers: {'Content-Type':'application/json'}
        )
    end
end
