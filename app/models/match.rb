class Match < ApplicationRecord
    #attr_accessible :mp_link, :warmup, :matchcost, :average_score
    belongs_to :tourney
    before_create :randomize_id
    #validate_presence_of :mp_link
    #validates_numericality_of :warmup, greater_than: -1, less_than: 3

    after_create_commit {
        broadcast_append_to(
            tourney, 
            partial: "frontend/matches/match", 
            locals: {match: self},
            target: "tourneys"
        )
    }
after_destroy_commit { broadcast_remove_to "matches", target: "match_#{id}" }
    
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
        end while Match.where(id: self.id).exists?
    end

    def filter_match(user, json)
        team_color = "none"
        blue = 0
        red = 0
        scores = []
        total_maps_played = []
        x = 0
        y = 0
        z = 0
        for h in json['events'] do
            if h.has_key? 'game'
                x += 1
                total_maps_played.append(h)
                for i in h['game']['scores']
                    if i.values[14]['team'] == 'blue'
                        blue = blue + i.values[4]
                    elsif i.values[14]['team'] == 'red'
                        red = red + i.values[4]
                    end
                    y += 1
                    if i.values.include? user.user_id # --> z.B. 9146098
                        z += 1
                        team_color = i.values[14]['team']
                        scores.append(i['score']) # Scores werden hinzugefügt
                    end
                end
            end
        end
        won = false
        if team_color == blue && blue > red || team_color == red && red > blue
            won = true
        end
        debugger
        return scores, won
    end
end
