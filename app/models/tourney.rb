class Tourney < ApplicationRecord
    belongs_to :user
    has_many :matches
    before_create :randomize_id
    validates :user, presence: true

    def self.fetchData(response)
        title = response['topic']['title']
        id = response['topic']['id']
        timestamp = response['topic']['created_at']
        timestamp = timestamp[0..9]
        cover_image = response['posts'][0]['body']['raw']
        urls = URI.extract(cover_image, ['http', 'https']) # first element is cover_image
        cover_image = urls[0]
        cover_image = cover_image.split("?")[0] if cover_image.include?("?")

        spreadsheet = ""
        urls.each do |url|
            spreadsheet = url if url.include?("spreadsheets")
        end

        year = timestamp[0..3]
        month = timestamp[5..6]
        day = timestamp[8..9]

        created_at = "#{day}.#{month}.#{year}"

        return title, year, month, id, spreadsheet, cover_image, created_at
    end

    private
    def randomize_id
        begin
            number = SecureRandom.random_number
            number = number.to_s.gsub(/\./mi, '')
            self.id = number
        end while Tourney.where(id: self.id).exists?
    end

end
