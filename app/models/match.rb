class Match < ApplicationRecord
    #attr_accessible :mp_link, :warmup, :matchcost, :average_score
    belongs_to :tourney
    def calculate
        
    end
end
