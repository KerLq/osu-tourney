class Match < ApplicationRecord
    #attr_accessible :mp_link, :warmup, :matchcost, :average_score
    belongs_to :tourney
    def calculate_matchcost

    end

    def self.calculate_average_score
        
    end
end
