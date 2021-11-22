class AddForumPostIdToTourney < ActiveRecord::Migration[6.1]
  def change
    add_column :tourneys, :forumpost_id, :bigint
  end
end
