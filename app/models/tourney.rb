class Tourney < ApplicationRecord
    attr_accessor :title, :spreadsheet
    belongs_to :user
    has_many :matches
end
