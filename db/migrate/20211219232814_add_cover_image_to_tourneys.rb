class AddCoverImageToTourneys < ActiveRecord::Migration[6.1]
  def change
    add_column :tourneys, :cover_image, :string
  end
end
