class Tourney < ApplicationRecord
    belongs_to :user
    has_many :matches
    before_create :randomize_id


    private
    def randomize_id
        begin
            number = SecureRandom.random_number
            number = number.to_s.gsub(/\./mi, '')
            self.id = number
        end while Tourney.where(id: self.id).exists?
    end

end
