class AddTourneyIdToMatches < ActiveRecord::Migration[6.1]
  def change
    add_column :matches, :tourney_id, :integer
  end
end
