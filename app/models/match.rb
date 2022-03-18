class Match < ApplicationRecord
    #attr_accessible :mp_link, :warmup, :matchcost, :average_score
    belongs_to :tourney
    before_create :randomize_id
    #validate_presence_of :mp_link
    #validates_numericality_of :warmup, greater_than: -1, less_than: 3
    validates :mp_link, presence: true, uniqueness: {scope: :tourney_id}
    def calculate_matchcost

    end

    def calculate_average_score(scores)
        average_score = 0
        for i in scores
            average_score += i;
        end
        average_score = average_score / scores.count if scores.count != 0
    end
    
    def randomize_id
        begin
            number = SecureRandom.random_number
            number = number.to_s.gsub(/\./mi, '')
            self.id = number
        end while Match.exists?(id: self.id)
    end

    def filter_match(user, response)
        return nil if response.to_s.exclude?("#{user.id}") || response['events'].to_s.exclude?('"game"=>') || response.has_key?("error")
        
        won = false
        team_color = "none"
        blue = 0
        red = 0
        total_score = []
        total_maps_played = []
        x = 0
        y = 0
        z = 0

        response['events'].each do |events|
            if events.has_key?('game')
                total_maps_played.append(events)
                events['game']['scores'].each do |scores|
                    blue = blue + scores['score'] if scores['match']['team'] == 'blue'
                    red = red + scores['score'] if scores['match']['team'] == 'red'
                    if scores.values.include?(user.user_id)
                        team_color = scores['match']['team']
                        total_score.append(scores['score'])
                    end
                end
            end
        end
        won = true if team_color == blue && blue > red || team_color == red && red > blue
        
        return total_score, won
    end
end
