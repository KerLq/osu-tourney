class Match < ApplicationRecord
    #attr_accessible :mp_link, :warmup, :matchcost, :average_score
    belongs_to :tourney
    def self.calculate_matchcost

    end

    def calculate_average_score(scores)
        average_score = 0
        for i in scores
            average_score += i;
        end
        average_score = average_score / scores.count
    end

    def filter_match(user, json)
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
                    y += 1
                    if i.values.include? user.user_id # --> z.B. 9146098
                        z += 1
                        scores.append(i['score']) # Scores werden hinzugefügt
                    end
                end
            end
        end
        scores
    end
end
