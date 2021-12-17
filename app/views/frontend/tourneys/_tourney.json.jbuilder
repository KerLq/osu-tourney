json.extract! tourney, :id, :title, :spreadsheet, :created_at, :updated_at
json.url user_tourney_url(tourney, format: :json)
