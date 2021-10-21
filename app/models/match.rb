class Match < ApplicationRecord
    attr_accessor :mp_link, :warmup, :matchcost, :average_score
    belongs_to :tourney
end
