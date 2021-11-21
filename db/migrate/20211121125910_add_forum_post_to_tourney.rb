class AddForumPostToTourney < ActiveRecord::Migration[6.1]
  def change
    add_column :tourneys, :forumpost, :text
  end
end
