class Tourney < ApplicationRecord
    attr_accessible :title, :spreadsheet
    belongs_to :user
    has_many :matches
end
