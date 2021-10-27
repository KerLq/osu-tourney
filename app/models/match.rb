class Match < ApplicationRecord
    #attr_accessible :mp_link, :warmup, :matchcost, :average_score
    belongs_to :tourney
    def self.calculate_matchcost

    end

    def calculate_average_score(match, scores)
        average_score = 0
        for i in scores
            average_score += i;
        end
        match.update(
            average_score = average_score / scores.count
        )
    end
end
