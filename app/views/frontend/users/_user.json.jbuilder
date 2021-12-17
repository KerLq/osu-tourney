json.extract! user, :id, :username, :avatar_url, :user_id, :created_at, :updated_at
json.url user_url(user, format: :json)
