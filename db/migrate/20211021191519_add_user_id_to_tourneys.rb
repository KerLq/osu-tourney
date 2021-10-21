class AddUserIdToTourneys < ActiveRecord::Migration[6.1]
  def change
    add_column :tourneys, :user_id, :integer
  end
end
